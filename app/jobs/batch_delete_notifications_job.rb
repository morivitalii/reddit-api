# frozen_string_literal: true

class BatchDeleteNotificationsJob < ApplicationJob
  queue_as :low_priority

  def perform(ids)
    BatchDeleteNotifications.new(ids: ids).call
  end
end
