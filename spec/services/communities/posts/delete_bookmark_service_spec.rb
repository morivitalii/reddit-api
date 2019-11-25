require "rails_helper"

RSpec.describe Communities::Posts::DeleteBookmarkService do
  describe ".call" do
    it "deletes post bookmark" do
      service = build_service

      expect { service.call }.to change { Bookmark.count }.by(-1)
    end
  end

  def build_service
    user = create(:user)
    post = create(:post_with_bookmark, bookmarked_by: user)

    described_class.new(post, user)
  end
end
