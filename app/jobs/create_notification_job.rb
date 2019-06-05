# frozen_string_literal: true

class CreateNotificationJob < ApplicationJob
  queue_as :low_priority

  def perform(id)
    CreateNotification.new(thing: Thing.find(id)).call
  end
end
