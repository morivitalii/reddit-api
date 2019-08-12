require "rails_helper"

RSpec.describe CreateBlacklistedDomainForm do
  subject { described_class }

  describe ".save" do
    let(:sub) { create(:sub) }
    let(:domain) { "test.com" }

    before do
      @form = subject.new(
        sub: sub,
        domain: domain
      )
    end

    it "creates blacklisted domain" do
      @form.save
      result = @form.blacklisted_domain

      expect(result).to have_attributes(sub: sub, domain: domain)
    end
  end
end