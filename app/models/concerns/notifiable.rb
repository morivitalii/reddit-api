# frozen_string_literal: true

module Notifiable
  extend ActiveSupport::Concern

  included do
    has_one :notification

    after_create :send_notification_on_create

    def send_notification_on_create
      if send_notification?
        create_notification(user: reply_to.user)
      end
    end

    def send_notification?
      comment? && user.id != reply_to.user.id && reply_to&.receive_notifications?
    end

    def reply_to
      comment.presence || post
    end
  end
end