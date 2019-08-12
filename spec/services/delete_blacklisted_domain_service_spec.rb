require "rails_helper"

RSpec.describe DeleteBlacklistedDomainService do
  subject { described_class }

  describe ".call" do
    let!(:blacklisted_domain) { create(:blacklisted_domain) }

    before do
      @service = subject.new(blacklisted_domain)
    end

    it "delete blacklisted domain" do
      expect { @service.call }.to change { BlacklistedDomain.count }.by(-1)
    end
  end
end