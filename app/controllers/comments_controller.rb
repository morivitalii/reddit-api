# frozen_string_literal: true

class CommentsController < ApplicationController
  include RateLimits

  before_action :set_comment, only: [:edit, :update, :approve, :new_destroy, :destroy]
  before_action :set_commentable_model, only: [:new, :create]
  before_action :set_sort_options, only: [:show]
  before_action :set_sort, only: [:show]
  before_action -> { authorize(Comment) }, only: [:new, :create]
  before_action -> { authorize(@comment) }, only: [:edit, :update, :approve, :new_destroy, :destroy]

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
    @form = CreateComment.new

    render partial: "new"
  end

  def edit
    @form = UpdateComment.new(text: @comment.text)

    render partial: "edit"
  end

  def create
    @form = CreateComment.new(create_params)

    rate_limit_key = :comments
    rate_limits = 200

    if check_rate_limits(@form, attribute: :text, key: rate_limit_key, limit: rate_limits) && @form.save
      hit_rate_limits(key: rate_limit_key)

      render partial: "things/comment", locals: { item: { thing: @form.comment } }
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    @form = UpdateComment.new(update_params)

    if @form.save
      render partial: "things/comment", locals: { item: { thing: @form.comment } }
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def approve
    ApproveComment.new(@comment, @current_user).call

    head :no_content
  end

  def new_destroy
    @form = DeleteComment.new(deletion_reason: @comment.deletion_reason)

    render partial: "new_destroy"
  end

  def destroy
    @form = DeleteComment.new(destroy_params)

    if @form.save
      head :no_content
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_commentable_model
    if params[:post_id].present?
      @commentable_model = Post.find(params[:post_id])
    elsif params[:comment_id].present?
      @commentable_model = Comment.find(params[:comment_id])
    end
  end

  def set_sort_options
    @sort_options = { best: t("best"), top: t("top"), new: t("new"), controversy: t("controversy"), old: t("old") }.with_indifferent_access
  end

  def set_sort
    @sort = params[:sort].in?(@sort_options.keys) ? params[:sort].to_sym : :best
  end

  def create_params
    params.require(:create_comment).permit(:text).merge(commentable_model: @commentable_model, current_user: current_user)
  end

  def update_params
    params.require(:update_comment).permit(policy(@comment).permitted_attributes_for_update).merge(comment: @comment, current_user: current_user)
  end

  def destroy_params
    params.require(:delete_comment).permit(policy(@comment).permitted_attributes_for_destroy).merge(comment: @comment, current_user: current_user)
  end
end
