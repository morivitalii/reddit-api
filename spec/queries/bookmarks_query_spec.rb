require "rails_helper"

RSpec.describe BookmarksQuery do
  subject { described_class }

  describe ".posts_bookmarks" do
    it "returns posts bookmarks" do
      posts_bookmarks = create_pair(:post_bookmark)
      create_pair(:comment_bookmark)

      result = subject.new.posts_bookmarks

      expect(result).to contain_exactly(*posts_bookmarks)
    end
  end

  describe ".comments_bookmarks" do
    it "returns comments bookmarks" do
      comments_bookmark = create_pair(:comment_bookmark)
      create_pair(:post_bookmark)

      result = subject.new.comments_bookmarks

      expect(result).to contain_exactly(*comments_bookmark)
    end
  end
end