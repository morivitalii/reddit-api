require "rails_helper"

RSpec.describe DeleteBookmarkService do
  subject { described_class.new(bookmarkable, user) }

  let!(:bookmarkable) { create(:post) }
  let!(:user) { create(:user) }
  let!(:bookmark) { create(:bookmark, bookmarkable: bookmarkable, user: user) }

  describe ".call" do
    it "delete bookmark" do
      expect { subject.call }.to change { Bookmark.count }.by(-1)
    end
  end
end