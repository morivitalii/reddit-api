require "rails_helper"

RSpec.describe Cleanup::RateLimitsService do
  subject { described_class.new }

  let!(:stale_rate_limit) { create(:rate_limit, :stale) }

  describe ".call" do
    it "delete stale rate limits" do
      expect { subject.call }.to change { RateLimit.count }.by(-1)
    end
  end
end