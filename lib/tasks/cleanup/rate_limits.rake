namespace :cleanup do
  desc "Cleanup stale rate limits"
  task rate_limits: :environment do
    Cleanup::StaleRateLimits.new.call
  end
end
