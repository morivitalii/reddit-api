# frozen_string_literal: true

class CommentsController < ApplicationController
  include RateLimits

  before_action :set_thing, only: [:new, :create]
  before_action :set_comment, only: [:edit, :update]
  before_action -> { authorize(@thing, policy_class: CommentPolicy) }, only: [:new, :create, :edit, :update]

  def new
    @form = CreateComment.new

    render partial: "new"
  end

  def edit
    @form = UpdateComment.new(text: @thing.text)

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

  private

  def set_thing
    @thing = Thing.find(params[:thing_id])
  end

  def set_comment
    @thing = Thing.where(thing_type: :comment).find(params[:thing_id])
  end

  def create_params
    params.require(:create_comment).permit(:text).merge(thing: @thing, current_user: current_user)
  end

  def update_params
    params.require(:update_comment).permit(:text).merge(comment: @thing, current_user: current_user)
  end
end
