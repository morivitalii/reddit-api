require "rails_helper"

RSpec.describe BlacklistedDomain do
  subject { described_class }

  it_behaves_like "paginatable"

  describe "uniqueness validation" do
    context "not unique" do
      let(:blacklisted_domain) { create(:blacklisted_domain) }

      it "adds error on domain attribute" do
        model = subject.new(domain: blacklisted_domain.domain)
        model.validate

        expected_result = { error: :taken }
        result = model.errors.details[:domain]

        expect(result).to include(expected_result)
      end
    end

    context "unique" do
      it "is valid" do
        model = subject.new(domain: "example.com")

        expect(model).to be_valid
      end
    end
  end
end