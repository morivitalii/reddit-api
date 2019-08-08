require "rails_helper"

class UserNotBannedValidatorDummy
  include ActiveModel::Validations

  attr_accessor :username

  validates :username, user_not_banned: true
end

RSpec.describe UserNotBannedValidator do
  subject { UserNotBannedValidatorDummy.new }

  let(:user) { create(:user) }

  describe ".validate_each" do
    context "invalid" do
      let!(:ban) { create(:ban, user: user) }

      it "adds error on username if user is banned" do
        subject.username = user.username

        subject.valid?
        expected_result = { error: :user_banned }
        result = subject.errors.details[:username]

        expect(result).to include(expected_result)
      end
    end

    context "valid" do
      it "does not add error on username attribute if user is not banned" do
        subject.username = user.username

        result = subject.valid?

        expect(result).to be_truthy
      end
    end
  end
end