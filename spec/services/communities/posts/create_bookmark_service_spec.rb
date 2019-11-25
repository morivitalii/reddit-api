require "rails_helper"

RSpec.describe Communities::Posts::CreateBookmarkService do
  describe ".call" do
    it "creates post bookmark" do
      service = build_service

      expect { service.call }.to change { Bookmark.count }.by(1)
    end
  end

  def build_service
    user = create(:user)
    post = create(:post)

    described_class.new(post, user)
  end
end
