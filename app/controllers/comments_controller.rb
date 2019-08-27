# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :approve, :remove, :destroy]
  before_action :set_commentable, only: [:new, :create]
  before_action :set_sort_options, only: [:show]
  before_action :set_sort, only: [:show]
  before_action -> { authorize(Comment) }, only: [:new, :create]
  before_action -> { authorize(@comment) }, only: [:edit, :update, :approve, :remove, :destroy]
  decorates_assigned :community, :comment

  def show
    # TODO
    # @topic = CommentsTree.new(
    #     thing: @thing,
    #     sort: @sort,
    #     after: params[:after].present? ? @community.things.find_by_id(params[:after]) : nil
    # ).build
    #
    # @post = @topic.post
    # @comment = @topic.comment
    # @community = @post.community
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

    rate_limit_action = :create_comment
    rate_limit = 200

    if validate_rate_limit(@form, attribute: :text, action: rate_limit_action, limit: rate_limit) && @form.save
      hit_rate_limit(rate_limit_action)

      render partial: "nested_comment", locals: { comment: @form.comment }
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    @form = UpdateComment.new(update_params)

    if @form.save
      @comment = @form.comment
      attributes = {
        text: comment.text_html,
        ignore_reports_link: comment.ignore_reports_link
      }

      render json: attributes
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def approve
    ApproveCommentService.new(@comment, current_user).call

    @comment = @comment.decorate

    render json: { approve_link: @comment.approve_link, remove_link: @comment.remove_link }
  end

  def remove
    @form = RemoveCommentForm.new(reason: @comment.removed_reason)

    render partial: "remove"
  end

  def destroy
    @form = RemoveCommentForm.new(destroy_params)

    if @form.save
      @comment = @comment.decorate

      render json: { approve_link: @comment.approve_link, remove_link: @comment.remove_link }
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def pundit_user
    # TODO
  end

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
    attributes = policy(Comment).permitted_attributes_for_create
    params.require(:create_comment).permit(attributes).merge(model: @commentable, current_user: current_user)
  end

  def update_params
    attributes = policy(@comment).permitted_attributes_for_update
    params.require(:update_comment).permit(attributes).merge(comment: @comment, current_user: current_user)
  end

  def destroy_params
    attributes = policy(@comment).permitted_attributes_for_destroy
    params.require(:remove_comment_form).permit(attributes).merge(comment: @comment, current_user: current_user)
  end
end
