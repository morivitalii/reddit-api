require "rails_helper"

class UsernameFormatValidatorDummy
  include ActiveModel::Validations

  attr_accessor :username

  validates :username, username_format: true
end

RSpec.describe UsernameFormatValidator do
  subject { UsernameFormatValidatorDummy.new }

  describe ".validate_each" do
    context "invalid" do
      it "adds error on username attribute if username format is wrong"do
        subject.username = "invalid username"

        subject.valid?
        expected_result = { error: :invalid_username_format }
        result = subject.errors.details[:username]

        expect(result).to include(expected_result)
      end
    end

    context "valid" do
      it "does not add error on username attribute if username format is valid"do
        subject.username = "username"

        result = subject.valid?

        expect(result).to be_truthy
      end
    end
  end
end