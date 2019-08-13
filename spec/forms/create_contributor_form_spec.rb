require "rails_helper"

RSpec.describe CreateContributorForm do
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

      let(:contributor_user) { create(:contributor, sub: sub).user }

      it "adds error on username field when user is contributor" do
        @form.username = contributor_user.username
        @form.save

        expect(@form).to have_error(:user_contributor).on(:username)
      end
    end

    context "valid" do
      let(:sub) { create(:sub) }
      let(:user) { create(:user) }
      let(:approved_by_user) { create(:user) }

      before do
        @form = subject.new(
          sub: sub,
          approved_by: approved_by_user,
          username: user.username
        )
      end

      it "approves user as contributor" do
        @form.save
        result = @form.contributor

        expect(result).to have_attributes(sub: sub, user: user, approved_by: approved_by_user)
      end
    end
  end
end