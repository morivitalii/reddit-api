require "rails_helper"

RSpec.describe BlacklistedDomainsQuery do
  subject { described_class }

  describe ".with_domain" do
    let!(:expected) { create(:blacklisted_domain) }
    let!(:others) { create_pair(:blacklisted_domain) }

    it "returns results filtered by domain" do
      result = subject.new.with_domain(expected.domain).take

      expect(result).to eq(expected)
    end
  end

  describe ".search_by_domain" do
    it "returns relation if domain is blank" do
      query = subject.new

      expected_result = query.relation
      result = query.search_by_domain("")

      expect(result).to eq(expected_result)
    end

    it "calls .with_domain if domain is present" do
      query = subject.new

      expect(query).to receive(:with_domain).with(anything)

      query.search_by_domain(anything)
    end
  end
end