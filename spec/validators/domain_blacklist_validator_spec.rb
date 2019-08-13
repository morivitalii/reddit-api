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
        subject.validate

        expect(subject).to have_error(:blacklisted_domain).on(:url)
      end
    end

    context "valid" do
      it "does not add error on url attribute if domain is not blacklisted" do
        subject.url = "example.com"

        expect(subject).to be_valid
      end
    end
  end
end