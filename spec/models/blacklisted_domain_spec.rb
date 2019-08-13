require "rails_helper"

RSpec.describe BlacklistedDomain do
  subject { described_class }

  it_behaves_like "paginatable"

  describe "uniqueness validation" do
    it "adds error on domain attribute if given value not unique" do
      sub = create(:sub)
      blacklisted_domain = create(:blacklisted_domain, sub: sub)
      model = subject.new(sub: sub, domain: blacklisted_domain.domain)
      model.validate

      expect(model).to have_error(:taken).on(:domain)
    end

    it "is valid if given value is unique" do
      sub = create(:sub)
      model = subject.new(sub: sub, domain: "example.com")
      model.validate

      expect(model).to_not have_error(:taken).on(:domain)
    end
  end
end