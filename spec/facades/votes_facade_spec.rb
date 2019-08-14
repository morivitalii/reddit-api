require "rails_helper"

RSpec.describe VotesFacade do
  subject { described_class }

  let(:user) { create(:user) }
  let(:community) { create(:community) }
  let(:context) { Context.new(user, community) }

  describe ".posts_meta_title" do
    it "returns title" do
      expected_result = "#{user.username}: #{I18n.t("posts_votes")}"
      result = subject.new(context, user).posts_meta_title

      expect(result).to eq(expected_result)
    end
  end

  describe ".comments_meta_title" do
    it "returns title" do
      expected_result = "#{user.username}: #{I18n.t("comments_votes")}"
      result = subject.new(context, user).comments_meta_title

      expect(result).to eq(expected_result)
    end
  end
end