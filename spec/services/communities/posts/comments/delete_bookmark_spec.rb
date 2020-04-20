require "rails_helper"

RSpec.describe Communities::Posts::Comments::DeleteBookmark do
  describe ".call" do
    it "deletes comment bookmark" do
      user = create(:user)
      comment = create(:comment_with_bookmark, bookmarked_by: user)
      service = described_class.new(comment: comment, user: user)

      service.call

      expect(service.comment.bookmarks.count).to eq(0)
    end
  end
end
