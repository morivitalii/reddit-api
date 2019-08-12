require "rails_helper"

class UserNotModeratorValidatorDummy
  include ActiveModel::Validations

  attr_accessor :username, :sub

  def initialize(sub)
    @sub = sub
  end

  validates :username, user_not_moderator: true
end

RSpec.describe UserNotModeratorValidator do
  subject { UserNotModeratorValidatorDummy.new(sub) }

  describe ".validate_each" do
    let(:sub) { create(:sub) }
    let(:user) { create(:user) }

    context "invalid" do
      let!(:moderator) { create(:moderator, user: user, sub: sub) }

      it "adds error on username if user is moderator" do
        subject.username = user.username

        subject.valid?

        expected_result = { error: :user_moderator }
        result = subject.errors.details[:username]

        expect(result).to include(expected_result)
      end
    end

    context "valid" do
      it "does not add error on username attribute if user is not moderator" do
        subject.username = user.username

        result = subject.valid?

        expect(result).to be_truthy
      end
    end
  end
end