require "rails_helper"

RSpec.describe RateLimitsQuery do
  subject { described_class }

  describe ".daily" do
    it "returns daily rate limits" do
      daily_rate_limits = create_pair(:rate_limit)
      create_pair(:stale_rate_limit)

      result = subject.new.daily

      expect(result).to contain_exactly(*daily_rate_limits)
    end
  end

  describe ".stale" do
    it "returns stale rate limits" do
      stale_rate_limits = create_pair(:stale_rate_limit)
      create_pair(:rate_limit)

      result = subject.new.stale

      expect(result).to contain_exactly(*stale_rate_limits)
    end
  end
end