# frozen_string_literal: true

class ThingDeleteController < BaseThingController
  def new
    ThingDeletePolicy.authorize!(:create, @thing)

    @form = MarkThingAsDeleted.new(deletion_reason: @thing.deletion_reason)

    render partial: "new"
  end

  def create
    ThingDeletePolicy.authorize!(:create, @thing)

    @form = MarkThingAsDeleted.new(create_params.merge(thing: @thing, current_user: Current.user))

    if @form.save
      head :no_content
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def create_params
    Current.user.staff? || Current.user.moderator?(@sub) ? params.require(:mark_thing_as_deleted).permit(:deletion_reason) : {}
  end
end
