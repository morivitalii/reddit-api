# frozen_string_literal: true

class StaleRateLimitsDeletion
  def call
    RateLimit.where("created_at < ?", DataRetentionTime.rate_limits).find_in_batches do |rate_limits|
      BatchDeleteRateLimitsJob.perform_later(rate_limits.map(&:id))
    end
  end
end
