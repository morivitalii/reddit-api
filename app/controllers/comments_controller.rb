# frozen_string_literal: true

class CommentsController < BaseThingController
  before_action :check_thing_type, only: [:edit, :update]

  def new
    CommentsPolicy.authorize!(:create, @sub)

    @form = CreateComment.new

    render partial: "new"
  end

  def edit
    CommentsPolicy.authorize!(:update, @thing)

    @form = UpdateComment.new(text: @thing.text)

    render partial: "edit"
  end

  def create
    CommentsPolicy.authorize!(:create, @sub)

    @form = CreateComment.new(create_params.merge(thing: @thing, current_user: Current.user))

    if @form.save
      render partial: "things/comment", locals: { item: { thing: @form.comment } }
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    CommentsPolicy.authorize!(:update, @thing)

    @form = UpdateComment.new(update_params.merge(comment: @thing))

    if @form.save
      render partial: "things/comment", locals: { item: { thing: @form.comment } }
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def check_thing_type
    unless @thing.comment?
      raise ActiveRecord::RecordNotFound
    end
  end

  def create_params
    params.require(:create_comment).permit(:text)
  end

  def update_params
    params.require(:update_comment).permit(:text)
  end
end
