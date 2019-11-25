namespace :cleanup do
  desc "Cleanup rate limits"
  task rate_limits: :environment do
    Cleanup::RateLimits.new.call
  end
end
