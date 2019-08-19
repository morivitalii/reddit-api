require "rails_helper"

RSpec.describe DeleteBookmarkService do
  subject { described_class }

  shared_examples "bookmark deletion" do
    it "deletes bookmark" do
      service = build_delete_bookmark_service(bookmarkable)

      expect { service.call }.to change { Bookmark.count }.by(-1)
    end
  end

  describe ".call" do
    context "when bookmarkable is post" do
      let(:bookmarkable) { create(:post) }

      include_examples "bookmark deletion"
    end

    context "when bookmarkable is comment" do
      let(:bookmarkable) { create(:comment) }

      include_examples "bookmark deletion"
    end
  end

  def build_delete_bookmark_service(bookmarkable)
    user = create(:user)
    create(:bookmark, bookmarkable: bookmarkable, user: user)

    described_class.new(bookmarkable, user)
  end
end