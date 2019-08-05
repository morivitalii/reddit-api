require "rails_helper"

RSpec.describe DeleteBlacklistedDomainService do
  subject { described_class.new(blacklisted_domain) }

  let!(:blacklisted_domain) { create(:blacklisted_domain) }

  describe ".call" do
    it "delete blacklisted domain" do
      expect { subject.call }.to change { BlacklistedDomain.count }.by(-1)
    end
  end
end