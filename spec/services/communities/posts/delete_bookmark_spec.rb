require "rails_helper"

RSpec.describe Communities::Posts::DeleteBookmark do
  describe ".call" do
    it "deletes post bookmark" do
      user = create(:user)
      post = create(:post_with_bookmark, bookmarked_by: user)
      service = described_class.new(post: post, user: user)

      service.call

      expect(service.post.bookmarks.count).to eq(0)
    end
  end
end
