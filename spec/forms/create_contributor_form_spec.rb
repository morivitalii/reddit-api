require "rails_helper"

RSpec.describe CreateContributorForm do
  subject { described_class }

  describe ".save" do
    context "invalid" do
      it "adds error on username field when username format is wrong" do
        form = subject.new(username: "")
        form.save

        result = form.errors.details[:username]
        expected_result = { error: :invalid_username_format }

        expect(result).to include(expected_result)
      end

      it "adds error on username field when user with given username is not exists" do
        form = subject.new(username: "username")
        form.save

        result = form.errors.details[:username]
        expected_result = { error: :invalid_username }

        expect(result).to include(expected_result)
      end

      let(:banned_user) { create(:ban).user }

      it "adds error on username field when user is banned" do
        form = subject.new(username: banned_user.username)
        form.save

        result = form.errors.details[:username]
        expected_result = { error: :user_banned }

        expect(result).to include(expected_result)
      end

      let(:moderator_user) { create(:moderator).user }

      it "adds error on username field when user is moderator" do
        form = subject.new(username: moderator_user.username)
        form.save

        result = form.errors.details[:username]
        expected_result = { error: :user_moderator }

        expect(result).to include(expected_result)
      end

      let(:contributor_user) { create(:contributor).user }

      it "adds error on username field when user is contributor" do
        form = subject.new(username: contributor_user.username)
        form.save

        result = form.errors.details[:username]
        expected_result = { error: :user_contributor }

        expect(result).to include(expected_result)
      end
    end

    context "valid" do
      let(:user) { create(:user) }
      let(:approved_by_user) { create(:user) }

      before do
        @form = subject.new(
          approved_by: approved_by_user,
          username: user.username
        )
      end

      it "approves user as contributor" do
        @form.save
        result = @form.contributor

        expect(result).to have_attributes(user: user, approved_by: approved_by_user)
      end
    end
  end
end