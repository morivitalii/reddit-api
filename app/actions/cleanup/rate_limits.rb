# frozen_string_literal: true

module Cleanup
  class RateLimits
    def self.call
      older_than = 1.day.ago

      RateLimit.where("created_at < ?", older_than).in_batches.each_record(&:destroy)
    end
  end
end
