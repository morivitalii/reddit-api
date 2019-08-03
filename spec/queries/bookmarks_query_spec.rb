require "rails_helper"

RSpec.describe BookmarksQuery do
  subject { described_class.new }

  describe ".filter_by_bookmarkable_type" do
    let!(:post_bookmarks) { [create(:post_bookmark, )] }
    let!(:comment_bookmarks) { [create(:comment_bookmark)] }

    it "returns all bookmarks" do
      expected_result = post_bookmarks + comment_bookmarks
      result = subject.filter_by_bookmarkable_type(nil).all

      expect(result).to eq(expected_result)
    end

    it "returns bookmarks with given type" do
      expected_result = post_bookmarks
      type = expected_result.first.bookmarkable_type
      result = subject.filter_by_bookmarkable_type(type).all

      expect(result).to eq(expected_result)
    end
  end

  describe ".where_user" do
    let!(:user) { create(:user) }
    let!(:user_bookmarks) { [create(:bookmark, user: user)] }
    let!(:bookmarks) { [create(:bookmark)] }

    it "returns bookmarks with given user" do
      expected_result = user_bookmarks
      result = subject.where_user(user).all

      expect(result).to eq(expected_result)
    end
  end
end