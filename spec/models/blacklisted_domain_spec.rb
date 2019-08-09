require "rails_helper"

RSpec.describe BlacklistedDomain do
  subject { described_class }

  it_behaves_like "paginatable"

  describe "uniqueness validation" do
    it "adds error on domain attribute if given value not unique" do
      blacklisted_domain = create(:blacklisted_domain)
      model = subject.new(domain: blacklisted_domain.domain)
      model.validate

      expected_result = { error: :taken }
      result = model.errors.details[:domain]

      expect(result).to include(expected_result)
    end

    it "is valid if given value is unique" do
      model = subject.new(domain: "example.com")
      model.validate

      expected_result = { error: :taken }
      result = model.errors.details[:domain]

      expect(result).to_not include(expected_result)
    end
  end
end