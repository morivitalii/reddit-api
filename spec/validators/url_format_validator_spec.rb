require "rails_helper"

class UrlFormatValidatorDummy
  include ActiveModel::Validations

  attr_accessor :url

  validates :url, url_format: true
end

RSpec.describe UrlFormatValidator do
  subject { UrlFormatValidatorDummy.new }

  describe ".validate_each" do
    context "invalid" do
      it "adds error on url attribute if format is wrong" do
        subject.url = "invalid url"

        subject.valid?
        expected_result = { error: :invalid }
        result = subject.errors.details[:url]

        expect(result).to include(expected_result)
      end
    end

    context "valid" do
      it "does not add error on url attribute if format is valid" do
        subject.url = "http://example.com/"

        result = subject.valid?

        expect(result).to be_truthy
      end
    end
  end
end