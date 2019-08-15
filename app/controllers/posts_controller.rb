# frozen_string_literal: true

class PostsController < ApplicationController
  include RateLimits

  before_action :set_post, only: [:show, :edit, :update, :approve, :remove, :destroy]
  before_action :set_community
  before_action :set_facade
  before_action :set_sort_options, only: [:show]
  before_action :set_sort, only: [:show]
  before_action -> { authorize(Post) }, only: [:new, :create]
  before_action -> { authorize(@post) }, only: [:show, :edit, :update, :approve, :remove, :destroy]

  def show
    # TODO js comments loading
    @post = @post.decorate
  end

  def new
    @form = CreatePost.new
  end

  def edit
    @form = UpdatePost.new(text: @post.text)
  end

  def create
    @form = CreatePost.new(create_params)

    rate_limit_key = :posts
    rate_limits = 100

    if check_rate_limits(@form, attribute: :title, key: rate_limit_key, limit: rate_limits) && @form.save
      hit_rate_limits(key: rate_limit_key)

      head :no_content, location: post_path(@form.post)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    @form = UpdatePost.new(update_params)

    if @form.save
      attributes = {
        spoiler: @form.post.spoiler,
        explicit: @form.post.explicit,
        ignore_reports: @form.post.ignore_reports
      }

      render json: attributes, location: post_path(@form.post)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def approve
    ApprovePostService.new(@post, current_user).call

    @post = @post.decorate

    render json: {
      approve_link_tooltip_message: @post.approve_link_tooltip_message,
      remove_link_tooltip_message: @post.remove_link_tooltip_message
    }
  end

  def remove
    @form = RemovePostForm.new(reason: @post.deletion_reason)

    render partial: "remove"
  end

  def destroy
    @form = RemovePostForm.new(destroy_params)

    if @form.save
      @post = @post.decorate

      render json: {
        approve_link_tooltip_message: @post.approve_link_tooltip_message,
        remove_link_tooltip_message: @post.remove_link_tooltip_message
      }
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def context
    Context.new(current_user, @community)
  end

  def set_community
    @community = @post.present? ? @post.community : CommunitiesQuery.new.with_url(params[:community_id]).take!
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_facade
    @facade = PostsFacade.new(context, @post)
  end

  def set_sort_options
    @sort_options = { best: t("best"), top: t("top"), new: t("new"), controversy: t("controversy"), old: t("old") }.with_indifferent_access
  end

  def set_sort
    @sort = params[:sort].in?(@sort_options.keys) ? params[:sort].to_sym : :best
  end

  def create_params
    permitted_attributes = policy(Post).permitted_attributes_for_create
    params.require(:create_post).permit(permitted_attributes).merge(community: @community, current_user: current_user)
  end

  def update_params
    permitted_attributes = policy(@post).permitted_attributes_for_update
    params.require(:update_post).permit(permitted_attributes).merge(post: @post, current_user: current_user)
  end

  def destroy_params
    permitted_attributes = policy(@post).permitted_attributes_for_destroy
    params.require(:remove_post_form).permit(permitted_attributes).merge(post: @post, user: current_user)
  end
end
