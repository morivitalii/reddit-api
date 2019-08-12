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

      expected_result = { error: :taken }
      result = model.errors.details[:domain]

      expect(result).to include(expected_result)
    end

    it "is valid if given value is unique" do
      sub = create(:sub)
      model = subject.new(sub: sub, domain: "example.com")
      model.validate

      expected_result = { error: :taken }
      result = model.errors.details[:domain]

      expect(result).to_not include(expected_result)
    end
  end
end