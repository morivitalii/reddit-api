# frozen_string_literal: true

class ThingSpoilerController < BaseThingController
  def create
    ThingSpoilerPolicy.authorize!(:create, @thing)

    MarkThingAsSpoiler.new(thing: @thing, current_user: Current.user).call

    head :no_content
  end

  def destroy
    ThingSpoilerPolicy.authorize!(:destroy, @thing)

    MarkThingAsNotSpoiler.new(thing: @thing, current_user: Current.user).call

    head :no_content
  end

  private

  def set_thing
    @thing = @sub.things.thing_type(:post).find(params[:id])
  end
end
