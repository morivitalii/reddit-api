# frozen_string_literal: true

module Cleanup
  class Notifications
    def self.call
      older_than = 3.months.ago

      Notification.where("created_at < ?", older_than).in_batches.each_record(&:destroy)
    end
  end
end
