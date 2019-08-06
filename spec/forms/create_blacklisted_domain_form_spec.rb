require "rails_helper"

RSpec.describe CreateBlacklistedDomainForm do
  subject { described_class.new(domain: domain) }

  let(:domain) { "test.com" }

  describe ".save" do
    it "creates blacklisted domain" do
      subject.save
      result = subject.blacklisted_domain

      expect(result).to have_attributes(domain: domain)
    end
  end
end