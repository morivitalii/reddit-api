require "rails_helper"

RSpec.describe BookmarksQuery do
  subject { described_class }

  describe ".for_posts" do
    it "returns bookmarks for posts" do
      bookmarks_for_posts = create_pair(:post_bookmark)
      _bookmarks_for_comments = create_pair(:comment_bookmark)

      result = subject.new.for_posts

      expect(result).to match_array(bookmarks_for_posts)
    end
  end

  describe ".for_comments" do
    it "returns bookmarks for comments" do
      bookmarks_for_comments = create_pair(:comment_bookmark)
      _bookmarks_for_posts = create_pair(:post_bookmark)

      result = subject.new.for_comments

      expect(result).to match_array(bookmarks_for_comments)
    end
  end
end
