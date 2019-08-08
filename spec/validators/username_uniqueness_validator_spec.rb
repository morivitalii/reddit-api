require "rails_helper"

class UsernameUniquenessValidatorDummy
  include ActiveModel::Validations

  attr_accessor :username

  validates :username, username_uniqueness: true
end

RSpec.describe UsernameUniquenessValidator do
  subject { UsernameUniquenessValidatorDummy.new }

  describe ".validate_each" do
    context "invalid" do
      let!(:user) { create(:user) }

      it "adds error on username attribute if username is taken" do
        subject.username = user.username

        subject.valid?
        expected_result = { error: :username_taken }
        result = subject.errors.details[:username]

        expect(result).to include(expected_result)
      end
    end

    context "valid" do
      it "does not add error on username attribute if username is not taken" do
        subject.username = "username"

        result = subject.valid?

        expect(result).to be_truthy
      end
    end
  end
end