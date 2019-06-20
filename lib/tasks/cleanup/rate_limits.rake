# frozen_string_literal: true

namespace :cleanup do
  desc "Cleanup rate limits"
  task rate_limits: :environment do
    Cleanup::RateLimits.call
  end
end
