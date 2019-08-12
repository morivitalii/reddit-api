require "rails_helper"

class DomainBlacklistValidatorDummy
  include ActiveModel::Validations

  attr_accessor :url, :sub

  def initialize(sub)
    @sub = sub
  end

  validates :url, domain_blacklist: true
end

RSpec.describe DomainBlacklistValidator do
  subject { DomainBlacklistValidatorDummy.new(sub) }

  describe ".validate_each" do
    let(:sub) { create(:sub) }

    context "invalid" do
      let!(:blacklisted_domain) { create(:blacklisted_domain, sub: sub) }

      it "adds error on url attribute if domain is blacklisted" do
        subject.url = blacklisted_domain.domain

        subject.valid?

        expected_result = { error: :blacklisted_domain }
        result = subject.errors.details[:url]

        expect(result).to include(expected_result)
      end
    end

    context "valid" do
      it "does not add error on url attribute if domain is not blacklisted" do
        subject.url = "example.com"

        result = subject.valid?

        expect(result).to be_truthy
      end
    end
  end
end