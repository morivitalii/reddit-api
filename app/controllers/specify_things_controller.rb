# frozen_string_literal: true

class SpecifyThingsController < BaseThingController
  def create
    SpecifyThingPolicy.authorize!(:create, @thing)

    MarkThingAsExplicit.new(thing: @thing, current_user: Current.user).call

    head :no_content
  end

  def destroy
    SpecifyThingPolicy.authorize!(:destroy, @thing)

    MarkThingAsNotExplicit.new(thing: @thing, current_user: Current.user).call

    head :no_content
  end

  private

  def set_thing
    @thing = @sub.things.thing_type(:post).find(params[:thing_id])
  end
end
