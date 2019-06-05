# frozen_string_literal: true

class ResetUserNotificationsCounter
  def initialize(current_user:)
    @current_user = current_user
  end

  def call
    return if @current_user.notifications_count.zero?

    User.where(id: @current_user.id).update_all(notifications_count: 0)
    @current_user.notifications_count = 0
  end
end
