require "rails_helper"

RSpec.describe CreateModeratorForm do
  subject { described_class }

  describe ".save" do
    context "invalid" do
      let(:sub) { create(:sub) }

      before do
        @form = subject.new(sub: sub)
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

      let(:banned_user) { create(:ban, sub: sub).user }

      it "adds error on username field when user is banned" do
        @form.username = banned_user.username
        @form.save

        expect(@form).to have_error(:user_banned).on(:username)
      end

      let(:moderator_user) { create(:moderator, sub: sub).user }

      it "adds error on username field when user is moderator" do
        @form.username = moderator_user.username
        @form.save

        expect(@form).to have_error(:user_moderator).on(:username)
      end
    end

    context "valid" do
      let(:sub) { create(:sub) }
      let(:user) { create(:user) }

      before do
        @form = subject.new(
          sub: sub,
          username: user.username
        )
      end

      it "invites user as moderator" do
        @form.save
        result = @form.moderator

        expect(result).to have_attributes(sub: sub, user: user)
      end
    end
  end
end