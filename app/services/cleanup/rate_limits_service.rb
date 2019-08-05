# frozen_string_literal: true

module Cleanup
  class RateLimitsService
    def call
      RateLimitsQuery.new.stale.in_batches.each_record(&:destroy)
    end
  end
end
