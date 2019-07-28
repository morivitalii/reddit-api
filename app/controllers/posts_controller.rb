# frozen_string_literal: true

class PostsController < ApplicationController
  include RateLimits

  before_action :set_sub, only: [:new, :create]
  before_action :set_post, only: [:edit, :update, :approve, :new_destroy, :destroy]
  before_action -> { authorize(nil, policy_class: PostPolicy) }, only: [:new, :create]
  before_action -> { authorize(@post) }, only: [:edit, :update, :approve, :new_destroy, :destroy]

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
    Approve.new(@post, @current_user).call

    head :no_content
  end

  def new_destroy
    @form = DeletePost.new(deletion_reason: @thing.deletion_reason)

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
    @sub = params[:sub].present? ? Sub.where("lower(url) = ?", params[:sub].downcase).take! : Sub.default
  end

  def set_post
    @post = Thing.where(thing_type: :post).find(params[:id])
  end

  def create_params
    params.require(:create_post).permit(:title, :text, :url, :file, :explicit, :spoiler).merge(sub: @sub, current_user: current_user)
  end

  def update_params
    params.require(:update_post).permit(:text).merge(post: @post, current_user: current_user)
  end

  def destroy_params
    params.require(:delete_post).permit(policy(@post).permitted_attributes_for_destroy).merge(post: @post, current_user: current_user)
  end
end
