require "rails_helper"

RSpec.describe Communities::Posts::Comments::CreateBookmark do
  describe ".call" do
    it "creates comment bookmark" do
      user = create(:user)
      comment = create(:comment)
      service = described_class.new(comment, user)

      service.call

      expect(service.comment.bookmarks.count).to eq(1)
    end
  end
end
