# frozen_string_literal: true

class ThingSubscriptionsController < BaseThingController
  before_action -> { authorize(@thing, policy_class: ThingSubscriptionPolicy) }

  def create
    SubscribeToThing.new(@thing).call

    head :no_content
  end

  def destroy
    UnsubscribeFromThing.new(@thing).call

    head :no_content
  end
end
