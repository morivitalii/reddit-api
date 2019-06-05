# frozen_string_literal: true

class UnsubscribeFromThingNotifications
  def initialize(thing)
    @thing = thing
  end

  def call
    @thing.update!(receive_notifications: false)
  end
end
