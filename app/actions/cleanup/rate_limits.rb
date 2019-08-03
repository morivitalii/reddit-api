# frozen_string_literal: true

module Cleanup
  class RateLimits
    def self.call
      RateLimitsQuery.new.stale.in_batches.each_record(&:destroy)
    end
  end
end
