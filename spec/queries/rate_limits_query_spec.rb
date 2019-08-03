require "rails_helper"

RSpec.describe RateLimitsQuery do
  subject { described_class.new }

  describe ".user_daily" do
    let!(:user) { create(:user) }
    let!(:user_rate_limits) { [create(:rate_limit, user: user)] }
    let!(:user_stale_rate_limits) { [create(:rate_limit, :stale, user: user)] }
    let!(:rate_limits) { [create(:rate_limit)] }

    it "returns daily user rate limits" do
      expected_result = user_rate_limits
      result = subject.user_daily(user).all

      expect(result).to eq(expected_result)
    end
  end

  describe ".stale" do
    let!(:rate_limits) { [create(:rate_limit)] }
    let!(:stale_rate_limits) { [create(:stale_rate_limit)] }

    it "returns stale rate limits" do
      expected_result = stale_rate_limits
      result = subject.stale.all

      expect(result).to eq(expected_result)
    end
  end
end