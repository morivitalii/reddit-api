require "rails_helper"

RSpec.describe BookmarksQuery do
  subject { described_class }

  describe ".with_bookmarkable_type" do
    it "returns bookmarks by given bookmarkable_type" do
      posts_bookmarks = create_pair(:post_bookmark)
      _comments_bookmarks = create_pair(:comment_bookmark)

      result = subject.new.with_bookmarkable_type("Post")

      expect(result).to match_array(posts_bookmarks)
    end
  end
end