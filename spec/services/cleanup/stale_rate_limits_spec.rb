require "rails_helper"

RSpec.describe Cleanup::RateLimitsService do
  describe ".call" do
    it "deletes stale rate limits" do
      create_pair(:rate_limit)
      create_pair(:stale_rate_limit)

      service = build_cleanup_rate_limits_service

      expect { service.call }.to change { RateLimit.count }.by(-2)
    end
  end

  def build_cleanup_rate_limits_service
    described_class.new
  end
end
