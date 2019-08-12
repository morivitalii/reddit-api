require "rails_helper"

RSpec.describe BookmarksFacade do
  subject { described_class }

  let(:user) { create(:user) }
  let(:sub) { create(:sub) }
  let(:context) { Context.new(user, sub) }

  describe ".posts_meta_title" do
    it "returns title" do
      expected_result = "#{user.username}: #{I18n.t("posts_bookmarks")}"
      result = subject.new(context, user).posts_meta_title

      expect(result).to eq(expected_result)
    end
  end

  describe ".comments_meta_title" do
    it "returns title" do
      expected_result = "#{user.username}: #{I18n.t("comments_bookmarks")}"
      result = subject.new(context, user).comments_meta_title

      expect(result).to eq(expected_result)
    end
  end
end