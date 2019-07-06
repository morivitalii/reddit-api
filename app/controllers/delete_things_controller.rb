# frozen_string_literal: true

class DeleteThingsController < BaseThingController
  before_action -> { authorize(@thing, policy_class: DeleteThingPolicy) }

  def new
    @form = MarkThingAsDeleted.new(deletion_reason: @thing.deletion_reason)

    render partial: "new"
  end

  def create
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
