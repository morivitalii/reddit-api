# frozen_string_literal: true

class ThingExplicitController < BaseThingController
  def create
    ThingExplicitPolicy.authorize!(:create, @thing)

    MarkThingAsExplicit.new(thing: @thing, current_user: Current.user).call

    head :no_content
  end

  def destroy
    ThingExplicitPolicy.authorize!(:destroy, @thing)

    MarkThingAsNotExplicit.new(thing: @thing, current_user: Current.user).call

    head :no_content
  end

  private

  def set_thing
    @thing = @sub.things.thing_type(:post).find(params[:id])
  end
end
