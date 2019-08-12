require "rails_helper"

RSpec.describe RateLimitsQuery do
  subject { described_class }

  describe ".daily" do
    let!(:expected) { create_pair(:rate_limit) }
    let!(:others) { create_pair(:rate_limit, :stale) }

    it "returns results filtered by daily" do
      result = subject.new.daily

      expect(result).to contain_exactly(*expected)
    end
  end

  describe ".stale" do
    let!(:expected) { create_pair(:rate_limit, :stale) }
    let!(:others) { create_pair(:rate_limit) }

    it "returns results filtered by stale" do
      result = subject.new.stale

      expect(result).to contain_exactly(*expected)
    end
  end
end