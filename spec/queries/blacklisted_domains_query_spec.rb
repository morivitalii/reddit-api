require "rails_helper"

RSpec.describe BlacklistedDomainsQuery do
  subject { described_class.new }

  describe ".where_sub" do
    let!(:sub) { create(:sub) }
    let!(:blacklisted_domains) { [create(:sub_blacklisted_domain, sub: sub)] }

    it "returns sub blacklisted domains" do
      expected_result = blacklisted_domains
      result = subject.where_sub(sub).all

      expect(result).to eq(expected_result)
    end
  end

  describe ".where_global" do
    let!(:blacklisted_domains) { [create(:global_blacklisted_domain)] }

    it "returns global blacklisted domains" do
      expected_result = blacklisted_domains
      result = subject.where_global.all

      expect(result).to eq(expected_result)
    end
  end

  describe ".where_global_and_sub" do
    let!(:sub) { create(:sub) }
    let!(:sub_blacklisted_domains) { [create(:sub_blacklisted_domain, sub: sub)] }
    let!(:global_blacklisted_domains) { [create(:global_blacklisted_domain)] }

    it "returns global and sub blacklisted domains" do
      expected_result = sub_blacklisted_domains + global_blacklisted_domains
      result = subject.where_global_and_sub(sub)

      expect(result).to eq(expected_result)
    end
  end

  describe ".filter_by_domain" do
    let!(:blacklisted_domains) { create_pair(:blacklisted_domain) }

    it "returns blacklisted domains if given domain is blank" do
      expected_result = blacklisted_domains
      result = subject.filter_by_domain(nil).all

      expect(result).to eq(expected_result)
    end

    it "returns blacklisted domain where domain is given domain" do
      expected_result = [blacklisted_domains.first]
      domain = expected_result.first.domain
      result = subject.filter_by_domain(domain).all

      expect(result).to eq(expected_result)
    end
  end
end