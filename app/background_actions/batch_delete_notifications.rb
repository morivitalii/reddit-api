# frozen_string_literal: true

class BatchDeleteNotifications
  def initialize(ids:)
    @ids = ids
  end

  def call
    Notification.where(id: @ids).delete_all
  end
end
