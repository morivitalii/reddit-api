# frozen_string_literal: true

class CommentsController < ApplicationController
  include RateLimits

  before_action :set_comment, only: [:edit, :update, :approve, :remove, :destroy]
  before_action :set_commentable, only: [:new, :create]
  before_action :set_sort_options, only: [:show]
  before_action :set_sort, only: [:show]
  before_action -> { authorize(Comment) }, only: [:new, :create]
  before_action -> { authorize(@comment) }, only: [:edit, :update, :approve, :remove, :destroy]

  def show
    # TODO
    # @topic = CommentsTree.new(
    #     thing: @thing,
    #     sort: @sort,
    #     after: params[:after].present? ? @sub.things.find_by_id(params[:after]) : nil
    # ).build
    #
    # @post = @topic.post
    # @comment = @topic.comment
    # @sub = @post.sub
    #
    # if request.xhr?
    #   if @comment.present?
    #     render partial: "nested", locals: { item: @topic.branch[:nested].first }
    #   else
    #     render partial: "nested", locals: { item: @topic.branch }
    #   end
    # else
    #   render "show", status: @thing.removed? ? :not_found : :ok
    # end
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

      render partial: "nested_comment", locals: { comment: @form.comment }
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    @form = UpdateComment.new(update_params)

    if @form.save
      attributes = {
        text: @form.comment.text_html,
        ignore_reports: @form.comment.ignore_reports
      }

      render json: attributes
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def approve
    ApproveCommentService.new(@comment, current_user).call

    @comment = @comment.decorate

    render json: {
      approve_link_tooltip_message: @comment.approve_link_tooltip_message,
      remove_link_tooltip_message: @comment.remove_link_tooltip_message
    }
  end

  def remove
    @form = RemoveCommentForm.new(reason: @comment.deletion_reason)
    @deletion_reasons = DeletionReasonsQuery.new.global_or_sub(@comment.sub).all

    render partial: "remove"
  end

  def destroy
    @form = RemoveCommentForm.new(destroy_params)

    if @form.save
      @comment = @comment.decorate

      render json: {
        approve_link_tooltip_message: @comment.approve_link_tooltip_message,
        remove_link_tooltip_message: @comment.remove_link_tooltip_message
      }
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_commentable
    if params[:post_id].present?
      @commentable = Post.find(params[:post_id])
    elsif params[:comment_id].present?
      @commentable = Comment.find(params[:comment_id])
    end
  end

  def set_sort_options
    @sort_options = { best: t("best"), top: t("top"), new: t("new"), controversy: t("controversy"), old: t("old") }.with_indifferent_access
  end

  def set_sort
    @sort = params[:sort].in?(@sort_options.keys) ? params[:sort].to_sym : :best
  end

  def create_params
    params.require(:create_comment).permit(:text).merge(model: @commentable, current_user: current_user)
  end

  def update_params
    params.require(:update_comment).permit(policy(@comment).permitted_attributes_for_update).merge(comment: @comment, current_user: current_user)
  end

  def destroy_params
    params.require(:remove_comment_form).permit(policy(@comment).permitted_attributes_for_destroy).merge(comment: @comment, current_user: current_user)
  end
end
