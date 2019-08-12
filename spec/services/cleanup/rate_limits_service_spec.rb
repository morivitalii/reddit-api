require "rails_helper"

RSpec.describe Cleanup::RateLimitsService do
  subject { described_class }

  describe ".call" do
    let!(:stale_rate_limit) { create(:rate_limit, :stale) }

    before do
      @service = subject.new
    end

    it "delete stale rate limits" do
      expect { @service.call }.to change { RateLimit.count }.by(-1)
    end
  end
end