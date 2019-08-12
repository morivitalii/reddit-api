require "rails_helper"

class EmailFormatValidatorDummy
  include ActiveModel::Validations

  attr_accessor :email

  validates :email, email_format: true
end

RSpec.describe EmailFormatValidator do
  subject { EmailFormatValidatorDummy.new }

  describe ".validate_each" do
    context "invalid" do
      it "adds error on email attribute if email format is wrong"do
        subject.email = "invalid email"

        subject.valid?

        expected_result = { error: :invalid }
        result = subject.errors.details[:email]

        expect(result).to include(expected_result)
      end
    end

    context "valid" do
      it "does not add error on email attribute if email format is valid"do
        subject.email = "valid@email.com"

        result = subject.valid?

        expect(result).to be_truthy
      end
    end
  end
end