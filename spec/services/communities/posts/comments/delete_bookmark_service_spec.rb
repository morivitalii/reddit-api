require "rails_helper"

RSpec.describe Communities::Posts::Comments::DeleteBookmarkService do
  describe ".call" do
    it "deletes comment bookmark" do
      service = build_service

      expect { service.call }.to change { Bookmark.count }.by(-1)
    end
  end

  def build_service
    user = create(:user)
    comment = create(:comment_with_bookmark, bookmarked_by: user)

    described_class.new(comment, user)
  end
end
