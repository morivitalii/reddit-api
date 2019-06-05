# frozen_string_literal: true

class ThingNotificationsController < BaseThingController
  def create
    ThingNotificationsPolicy.authorize!(:create, @thing)

    SubscribeToThingNotifications.new(@thing).call

    head :no_content
  end

  def destroy
    ThingNotificationsPolicy.authorize!(:destroy, @thing)

    UnsubscribeFromThingNotifications.new(@thing).call

    head :no_content
  end
end
