# frozen_string_literal: true

class SpecifyThingsController < BaseThingController
  before_action -> { authorize(@thing, policy_class: SpecifyThingPolicy) }

  def create
    MarkThingAsExplicit.new(thing: @thing, current_user: current_user).call

    head :no_content
  end

  def destroy
    MarkThingAsNotExplicit.new(thing: @thing, current_user: current_user).call

    head :no_content
  end

  private

  def set_thing
    @thing = Thing.find(params[:id])
  end
end
