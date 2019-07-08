# frozen_string_literal: true

class ThingSubscriptionsController < ApplicationController
  before_action :set_thing
  before_action -> { authorize(@thing, policy_class: ThingSubscriptionPolicy) }

  def create
    SubscribeToThing.new(@thing).call

    head :no_content
  end

  def destroy
    UnsubscribeFromThing.new(@thing).call

    head :no_content
  end

  private

  def set_thing
    @thing = Thing.find(params[:thing_id])
  end
end
