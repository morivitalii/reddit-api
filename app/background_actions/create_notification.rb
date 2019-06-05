# frozen_string_literal: true

class CreateNotification
  def initialize(thing:)
    @thing = thing
  end

  def call
    return unless send?

    Notification.create!(user: @thing.replied_to.user, thing: @thing)
  end

  def call_later
    return unless send?

    CreateNotificationJob.perform_later(@thing.id)
  end

  private

  def send?
    @thing.comment? && !@thing.replied_to_yourself? && @thing.replied_to.receive_notifications?
  end
end
