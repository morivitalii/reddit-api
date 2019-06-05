# frozen_string_literal: true

class StaleNotificationsDeletionJob < ApplicationJob
  queue_as :high_priority

  def perform
    StaleNotificationsDeletion.new.call
  end
end
