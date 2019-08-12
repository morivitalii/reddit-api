require "rails_helper"

RSpec.describe BookmarksQuery do
  subject { described_class }

  describe ".posts_bookmarks" do
    let!(:expected) { create_pair(:post_bookmark) }
    let!(:others) { create_pair(:comment_bookmark) }

    it "returns posts bookmarks" do
      result = subject.new.posts_bookmarks

      expect(result).to contain_exactly(*expected)
    end
  end

  describe ".comments_bookmarks" do
    let!(:expected) { create_pair(:comment_bookmark) }
    let!(:others) { create_pair(:post_bookmark) }

    it "returns posts bookmarks" do
      result = subject.new.comments_bookmarks

      expect(result).to contain_exactly(*expected)
    end
  end
end