require "rails_helper"

RSpec.describe Communities::Posts::Comments::CreateBookmarkService do
  describe ".call" do
    it "creates comment bookmark" do
      service = build_service

      expect { service.call }.to change { Bookmark.count }.by(1)
    end
  end

  def build_service
    user = create(:user)
    comment = create(:comment)

    described_class.new(comment, user)
  end
end
