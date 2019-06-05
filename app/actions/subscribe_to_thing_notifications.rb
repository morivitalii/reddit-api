# frozen_string_literal: true

class SubscribeToThingNotifications
  def initialize(thing)
    @thing = thing
  end

  def call
    @thing.update!(receive_notifications: true)
  end
end
