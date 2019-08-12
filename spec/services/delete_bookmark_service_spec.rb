require "rails_helper"

RSpec.describe DeleteBookmarkService do
  subject { described_class }

  describe ".call" do
    let!(:bookmarkable) { create(:post) }
    let!(:user) { create(:user) }
    let!(:bookmark) { create(:bookmark, bookmarkable: bookmarkable, user: user) }

    before do
      @service = subject.new(bookmarkable, user)
    end

    it "delete bookmark" do
      expect { @service.call }.to change { Bookmark.count }.by(-1)
    end
  end
end