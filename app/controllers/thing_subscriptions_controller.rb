# frozen_string_literal: true

class ThingSubscriptionsController < BaseThingController
  def create
    ThingSubscriptionPolicy.authorize!(:create, @thing)

    SubscribeToThing.new(@thing).call

    head :no_content
  end

  def destroy
    ThingSubscriptionPolicy.authorize!(:destroy, @thing)

    UnsubscribeFromThing.new(@thing).call

    head :no_content
  end
end
