# frozen_string_literal: true

class SpoilerThingsController < BaseThingController
  before_action -> { authorize(@thing, policy_class: SpoilerThingPolicy) }

  def create
    MarkThingAsSpoiler.new(thing: @thing, current_user: current_user).call

    head :no_content
  end

  def destroy
    MarkThingAsNotSpoiler.new(thing: @thing, current_user: current_user).call

    head :no_content
  end

  private

  def set_thing
    @thing = @sub.things.thing_type(:post).find(params[:thing_id])
  end
end
