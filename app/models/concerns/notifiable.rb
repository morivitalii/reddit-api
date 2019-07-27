# frozen_string_literal: true

# TODO rework
module Notifiable
  extend ActiveSupport::Concern

  included do
    has_one :notification, as: :notifiable

    after_create :send_notification_on_create

    def send_notification_on_create
      if send_notification?
        create_notification(user: reply_to.user)
      end
    end

    def send_notification?
      is_a?(Comment) && user.id != reply_to.user.id && reply_to&.receive_notifications?
    end

    def reply_to
      parent.presence || post
    end
  end
end