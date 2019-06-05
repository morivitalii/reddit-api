# frozen_string_literal: true

class StaleNotificationsDeletion
  def call
    Notification.where("created_at < ?", DataRetentionTime.notifications).find_in_batches do |notifications|
      BatchDeleteNotificationsJob.perform_later(notifications.map(&:id))
    end
  end
end
