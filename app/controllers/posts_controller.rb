# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :approve, :remove, :destroy]
  before_action :set_community
  before_action -> { authorize(Post) }, only: [:new_text, :new_link, :new_image, :create]
  before_action -> { authorize(@post) }, only: [:show, :edit, :update, :approve, :remove, :destroy]
  decorates_assigned :community, :post

  def show
  end

  def new_text
    @form = CreatePostForm.new
  end

  def new_link
    @form = CreatePostForm.new
  end

  def new_image
    @form = CreatePostForm.new
  end

  def edit
    attributes = @post.slice(:text)

    @form = UpdatePostForm.new(attributes)
  end

  def create
    @form = CreatePostForm.new(create_params)

    rate_limit_action = :create_post
    rate_limit = 100

    if validate_rate_limit(@form, attribute: :title, action: rate_limit_action, limit: rate_limit) && @form.save
      hit_rate_limit(rate_limit_action)

      head :no_content, location: post_path(@form.post)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    @form = UpdatePostForm.new(update_params)

    if @form.save
      @post = @form.post
      attributes = {
        spoiler: post.spoiler,
        spoiler_link: post.spoiler_link,
        explicit: post.explicit,
        explicit_link: post.explicit_link,
        ignore_reports_link: post.ignore_reports_link,
      }

      render json: attributes, location: post_path(@form.post)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def approve
    ApprovePostService.new(@post, current_user).call

    render json: {approve_link: post.approve_link, remove_link: post.remove_link}
  end

  def remove
    @form = RemovePostForm.new(reason: @post.removed_reason)

    render partial: "remove"
  end

  def destroy
    @form = RemovePostForm.new(destroy_params)

    if @form.save
      render json: {approve_link: post.approve_link, remove_link: post.remove_link}
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def pundit_user
    Context.new(current_user, @community)
  end

  def set_community
    @community = @post.present? ? @post.community : CommunitiesQuery.new.with_url(params[:community_id]).take!
  end

  def set_post
    @post = Post.find(params[:id])
  end

  helper_method :sort
  def sort
    sorts.include?(params[:sort]) ? params[:sort] : :best
  end

  helper_method :sorts
  def sorts
    %w[best top new controversy old]
  end

  def create_params
    attributes = policy(Post).permitted_attributes_for_create
    params.require(:create_post_form).permit(attributes).merge(community: @community, user: current_user)
  end

  def update_params
    attributes = policy(@post).permitted_attributes_for_update
    params.require(:update_post_form).permit(attributes).merge(post: @post, user: current_user)
  end

  def destroy_params
    attributes = policy(@post).permitted_attributes_for_destroy
    params.require(:remove_post_form).permit(attributes).merge(post: @post, user: current_user)
  end
end
