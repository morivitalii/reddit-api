require "rails_helper"

RSpec.describe Cleanup::StaleRateLimits do
  describe ".call" do
    it "deletes stale rate limits" do
      create_pair(:rate_limit)
      create_pair(:stale_rate_limit)
      service = described_class.new

      service.call

      expect(RateLimit.count).to eq(2)
    end
  end
end
