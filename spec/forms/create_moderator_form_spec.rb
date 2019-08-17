require "rails_helper"

RSpec.describe CreateModeratorForm, type: :form do
  subject { described_class }

  describe ".save" do
    context "invalid" do
      let(:community) { create(:community) }

      before do
        @form = subject.new(community: community)
      end

      it "adds error on username field when username format is wrong" do
        @form.username = ""
        @form.save

        expect(@form).to have_error(:invalid_username_format).on(:username)
      end

      it "adds error on username field when user with given username is not exists" do
        @form.username = "username"
        @form.save

        expect(@form).to have_error(:invalid_username).on(:username)
      end

      let(:banned_user) { create(:ban, community: community).user }

      it "adds error on username field when user is banned" do
        @form.username = banned_user.username
        @form.save

        expect(@form).to have_error(:user_banned).on(:username)
      end

      let(:moderator_user) { create(:moderator, community: community).user }

      it "adds error on username field when user is moderator" do
        @form.username = moderator_user.username
        @form.save

        expect(@form).to have_error(:user_moderator).on(:username)
      end
    end

    context "valid" do
      let(:community) { create(:community) }
      let(:user) { create(:user) }

      before do
        @form = subject.new(
          community: community,
          username: user.username
        )
      end

      it "invites user as moderator" do
        @form.save
        result = @form.moderator

        expect(result).to have_attributes(community: community, user: user)
      end
    end
  end
end