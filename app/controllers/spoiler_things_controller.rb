# frozen_string_literal: true

class SpoilerThingsController < ApplicationController
  before_action :set_thing
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
    @thing = Thing.find(params[:thing_id])
  end
end
