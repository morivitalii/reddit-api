# frozen_string_literal: true

class SubscribeToThing
  def initialize(thing)
    @thing = thing
  end

  def call
    @thing.update!(receive_notifications: true)
  end
end
