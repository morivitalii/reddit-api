require "rails_helper"

class UsernameExistenceValidatorDummy
  include ActiveModel::Validations

  attr_accessor :username

  validates :username, username_existence: true
end

RSpec.describe UsernameExistenceValidator do
  subject { UsernameExistenceValidatorDummy.new }

  describe ".validate_each" do
    context "invalid" do
      let!(:user) { create(:user) }

      it "adds error on username attribute if user with given username does not exist" do
        subject.username = "username"

        subject.valid?
        expected_result = { error: :invalid_username }
        result = subject.errors.details[:username]

        expect(result).to include(expected_result)

      end
    end

    context "valid" do
      let!(:user) { create(:user) }

      it "does not add error on username attribute if user with given username exist" do
        subject.username = user.username

        result = subject.valid?

        expect(result).to be_truthy
      end
    end
  end
end