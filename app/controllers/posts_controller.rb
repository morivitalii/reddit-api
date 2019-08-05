# frozen_string_literal: true

class PostsController < ApplicationController
  include RateLimits

  before_action :set_sub, only: [:new, :create]
  before_action :set_post, only: [:show, :edit, :tag, :update, :approve, :remove, :destroy]
  before_action :set_sort_options, only: [:show]
  before_action :set_sort, only: [:show]
  before_action -> { authorize(Post) }, only: [:new, :create]
  before_action -> { authorize(@post) }, only: [:tag, :edit, :update, :approve, :remove, :destroy]

  def show
    # TODO js comments loading
    @post = @post.decorate
  end

  def new
    @form = CreatePost.new
  end

  def tag
    @form = UpdatePost.new(text: @post.tag)
    @tags = TagsQuery.new.global_or_sub(@post.sub).all

    render partial: "tag"
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
        tag: @form.post.tag,
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
    @deletion_reasons = DeletionReasonsQuery.new.global_or_sub(@post.sub).all

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

  def pundit_user
    Context.new(current_user, @sub || @post&.sub)
  end

  def set_sub
    query_class = SubsQuery

    if params[:sub].present?
      @sub = query_class.new.where_url(params[:sub]).take!
    else
      @sub = query_class.new.default.take!
    end
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_sort_options
    @sort_options = { best: t("best"), top: t("top"), new: t("new"), controversy: t("controversy"), old: t("old") }.with_indifferent_access
  end

  def set_sort
    @sort = params[:sort].in?(@sort_options.keys) ? params[:sort].to_sym : :best
  end

  def create_params
    params.require(:create_post).permit(:title, :text, :url, :media, :explicit, :spoiler).merge(sub: @sub, current_user: current_user)
  end

  def update_params
    params.require(:update_post).permit(policy(@post).permitted_attributes_for_update).merge(post: @post, current_user: current_user)
  end

  def destroy_params
    params.require(:remove_post_form).permit(policy(@post).permitted_attributes_for_destroy).merge(post: @post, user: current_user)
  end
end
