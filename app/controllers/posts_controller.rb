# frozen_string_literal: true

class PostsController < ApplicationController
  include RateLimits

  before_action :set_sub, only: [:new, :create]
  before_action :set_post, only: [:edit, :update, :approve, :new_destroy, :destroy]
  before_action :set_sort_options, only: [:show]
  before_action :set_sort, only: [:show]
  before_action -> { authorize(Post) }, only: [:new, :create]
  before_action -> { authorize(@post) }, only: [:edit, :update, :approve, :new_destroy, :destroy]

  def show
    @topic = CommentsTree.new(
        thing: @thing,
        sort: @sort,
        after: params[:after].present? ? @sub.things.find_by_id(params[:after]) : nil
    ).build

    @post = @topic.post
    @comment = @topic.comment
    @sub = @post.sub

    if request.xhr?
      if @comment.present?
        render partial: "nested", locals: { item: @topic.branch[:nested].first }
      else
        render partial: "nested", locals: { item: @topic.branch }
      end
    else
      render "show", status: @thing.deleted? ? :not_found : :ok
    end
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

      head :no_content, location: thing_path(@form.post)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    @form = UpdatePost.new(update_params)

    if @form.save
      head :no_content, location: thing_path(@form.post)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def approve
    ApprovePost.new(@post, @current_user).call

    head :no_content
  end

  def new_destroy
    @form = DeletePost.new(deletion_reason: @post.deletion_reason)

    render partial: "new_destroy"
  end

  def destroy
    @form = DeletePost.new(destroy_params)

    if @form.save
      head :no_content
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def pundit_user
    UserContext.new(current_user, @sub || @post&.sub)
  end

  def set_sub
    @sub = Sub.find_by_lower_url(params[:sub])
  end

  def set_post
    @post = Thing.where(thing_type: :post).find(params[:id])
  end

  def set_sort_options
    @sort_options = { best: t("best"), top: t("top"), new: t("new"), controversy: t("controversy"), old: t("old") }.with_indifferent_access
  end

  def set_sort
    @sort = params[:sort].in?(@sort_options.keys) ? params[:sort].to_sym : :best
  end

  def create_params
    params.require(:create_post).permit(:title, :text, :url, :file, :explicit, :spoiler).merge(sub: @sub, current_user: current_user)
  end

  def update_params
    params.require(:update_post).permit(policy(@post).permitted_attributes_for_update).merge(post: @post, current_user: current_user)
  end

  def destroy_params
    params.require(:delete_post).permit(policy(@post).permitted_attributes_for_destroy).merge(post: @post, current_user: current_user)
  end
end
