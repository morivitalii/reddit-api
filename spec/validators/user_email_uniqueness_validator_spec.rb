require "rails_helper"

class UserEmailUniquenessValidatorDummy
  include ActiveModel::Validations

  attr_accessor :email

  validates :email, user_email_uniqueness: true
end

RSpec.describe UserEmailUniquenessValidator do
  subject { UserEmailUniquenessValidatorDummy.new }

  describe ".validate_each" do
    context "invalid" do
      let!(:user) { create(:user) }

      it "adds error on email attribute if email is taken" do
        subject.email = user.email

        subject.valid?
        expected_result = { error: :email_taken }
        result = subject.errors.details[:email]

        expect(result).to include(expected_result)
      end
    end

    context "valid" do
      it "does not add error on email attribute if email is not taken" do
        subject.email = "valid@email.com"

        result = subject.valid?

        expect(result).to be_truthy
      end
    end
  end
end