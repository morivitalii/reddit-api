require "rails_helper"

RSpec.describe Communities::Posts::CreateBookmark do
  describe ".call" do
    it "creates post bookmark" do
      user = create(:user)
      post = create(:post)
      service = described_class.new(post: post, user: user)

      service.call

      expect(service.post.bookmarks.count).to eq(1)
    end
  end
end
