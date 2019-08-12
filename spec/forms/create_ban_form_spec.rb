require "rails_helper"

RSpec.describe CreateBanForm do
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

        result = @form.errors.details[:username]
        expected_result = { error: :invalid_username_format }

        expect(result).to include(expected_result)
      end

      it "adds error on username field when user with given username is not exists" do
        @form.username = "username"
        @form.save

        result = @form.errors.details[:username]
        expected_result = { error: :invalid_username }

        expect(result).to include(expected_result)
      end

      let(:banned_user) { create(:ban, sub: sub).user }

      it "adds error on username field when user is banned" do
        @form.username = banned_user.username
        @form.save

        result = @form.errors.details[:username]
        expected_result = { error: :user_banned }

        expect(result).to include(expected_result)
      end

      let(:moderator_user) { create(:moderator, sub: sub).user }

      it "adds error on username field when user is moderator" do
        @form.username = moderator_user.username
        @form.save

        result = @form.errors.details[:username]
        expected_result = { error: :user_moderator }

        expect(result).to include(expected_result)
      end
    end

    context "valid" do
      let(:sub) { create(:sub) }
      let(:user) { create(:user) }
      let(:banned_by_user) { create(:user) }

      before do
        @form = subject.new(
          sub: sub,
          banned_by: banned_by_user,
          username: user.username,
          permanent: true
        )
      end

      it "bans user" do
        @form.save
        result = @form.ban

        expect(result).to have_attributes(sub: sub, user: user, banned_by: banned_by_user)
      end
    end
  end
end