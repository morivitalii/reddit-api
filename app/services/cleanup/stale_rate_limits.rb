class Cleanup::StaleRateLimits
  def call
    RateLimitsQuery.new.stale.in_batches.each_record(&:destroy)
  end
end
