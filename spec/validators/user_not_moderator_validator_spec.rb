require "rails_helper"

class UserNotModeratorValidatorDummy
  include ActiveModel::Validations

  attr_accessor :username, :community

  def initialize(community)
    @community = community
  end

  validates :username, user_not_moderator: true
end

RSpec.describe UserNotModeratorValidator do
  subject { UserNotModeratorValidatorDummy.new(community) }

  describe ".validate_each" do
    let(:community) { create(:community) }
    let(:user) { create(:user) }

    context "invalid" do
      let!(:moderator) { create(:moderator, user: user, community: community) }

      it "adds error on username if user is moderator" do
        subject.username = user.username
        subject.validate

        expect(subject).to have_error(:user_moderator).on(:username)
      end
    end

    context "valid" do
      it "does not add error on username attribute if user is not moderator" do
        subject.username = user.username

        expect(subject).to be_valid
      end
    end
  end
end