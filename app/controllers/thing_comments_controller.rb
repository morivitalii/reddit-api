# frozen_string_literal: true

class ThingCommentsController < BaseThingController
  before_action :check_thing_type, only: [:edit, :update]

  def new
    ThingCommentsPolicy.authorize!(:create, @sub)

    @form = CreateThingComment.new

    render partial: "new"
  end

  def edit
    ThingCommentsPolicy.authorize!(:update, @thing)

    @form = UpdateThingComment.new(text: @thing.text)

    render partial: "edit"
  end

  def create
    ThingCommentsPolicy.authorize!(:create, @sub)

    @form = CreateThingComment.new(create_params.merge(thing: @thing, current_user: Current.user))
    @form.save!

    render partial: "things/comment", locals: { item: { thing: @form.comment } }
  end

  def update
    ThingCommentsPolicy.authorize!(:update, @thing)

    @form = UpdateThingComment.new(update_params.merge(comment: @thing))
    @form.save!

    render partial: "things/comment", locals: { item: { thing: @form.comment } }
  end

  private

  def check_thing_type
    unless @thing.comment?
      raise ActiveRecord::RecordNotFound
    end
  end

  def create_params
    params.require(:create_thing_comment).permit(:text)
  end

  def update_params
    params.require(:update_thing_comment).permit(:text)
  end
end
