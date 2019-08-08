require "rails_helper"

class DomainBlacklistValidatorDummy
  include ActiveModel::Validations

  attr_accessor :url

  validates :url, domain_blacklist: true
end

RSpec.describe DomainBlacklistValidator do
  subject { DomainBlacklistValidatorDummy.new }

  describe ".validate_each" do
    context "invalid" do
      let!(:blacklisted_domain) { create(:blacklisted_domain) }

      it "adds error on url attribute if domain is blacklisted" do
        subject.url = "http://#{blacklisted_domain.domain}/"

        subject.valid?
        expected_result = { error: :blacklisted_domain }
        result = subject.errors.details[:url]

        expect(result).to include(expected_result)
      end
    end

    context "valid" do
      it "does not add error on url attribute if domain is not blacklisted" do
        subject.url = "http://example.com/"

        result = subject.valid?

        expect(result).to be_truthy
      end
    end
  end
end