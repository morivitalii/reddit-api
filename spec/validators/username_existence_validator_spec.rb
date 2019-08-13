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
        subject.validate

        expect(subject).to have_error(:invalid_username).on(:username)
      end
    end

    context "valid" do
      let!(:user) { create(:user) }

      it "does not add error on username attribute if user with given username exist" do
        subject.username = user.username

        expect(subject).to be_valid
      end
    end
  end
end