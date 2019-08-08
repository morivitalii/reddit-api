require "rails_helper"

class UserNotContributorValidatorDummy
  include ActiveModel::Validations

  attr_accessor :username

  validates :username, user_not_contributor: true
end

RSpec.describe UserNotContributorValidator do
  subject { UserNotContributorValidatorDummy.new }

  let(:user) { create(:user) }

  describe ".validate_each" do
    context "invalid" do
      let!(:contributor) { create(:contributor, user: user) }

      it "adds error on username if user is contributor" do
        subject.username = user.username

        subject.valid?
        expected_result = { error: :user_contributor }
        result = subject.errors.details[:username]

        expect(result).to include(expected_result)
      end
    end

    context "valid" do
      it "does not add error on username attribute if user is not contributor" do
        subject.username = user.username

        result = subject.valid?

        expect(result).to be_truthy
      end
    end
  end
end