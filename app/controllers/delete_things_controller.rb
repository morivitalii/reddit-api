# frozen_string_literal: true

class DeleteThingsController < BaseThingController
  def new
    DeleteThingPolicy.authorize!(:create, @thing)

    @form = MarkThingAsDeleted.new(deletion_reason: @thing.deletion_reason)

    render partial: "new"
  end

  def create
    DeleteThingPolicy.authorize!(:create, @thing)

    @form = MarkThingAsDeleted.new(create_params.merge(thing: @thing, current_user: current_user))

    if @form.save
      head :no_content
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def create_params
    current_user.staff? || current_user.moderator?(@sub) ? params.require(:mark_thing_as_deleted).permit(:deletion_reason) : {}
  end
end
