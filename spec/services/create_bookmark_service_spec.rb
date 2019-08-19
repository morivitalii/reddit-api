require "rails_helper"

RSpec.describe CreateBookmarkService do
  subject { described_class }

  shared_examples "bookmark exists" do
    context "and when bookmark exists" do
      it "does not create new one" do
        service = build_create_bookmark_service(bookmarkable)
        bookmark = instance_double(Bookmark)
        allow(service).to receive(:bookmark).and_return(bookmark)

        expect { service.call }.to_not change { Bookmark.count }
      end

      it "returns existent bookmark" do
        service = build_create_bookmark_service(bookmarkable)
        bookmark = instance_double(Bookmark)
        allow(service).to receive(:bookmark).and_return(bookmark)

        result = service.call

        expect(result).to eq(bookmark)
      end
    end
  end

  shared_examples "bookmark does not exist" do
    context "and when bookmark does not exist" do
      it "creates new one" do
        service = build_create_bookmark_service(bookmarkable)

        expect { service.call }.to change { Bookmark.count }.by(1)
      end

      it "returns created bookmark" do
        service = build_create_bookmark_service(bookmarkable)

        bookmark = service.call
        expect(bookmark).to be_persisted
        expect(bookmark.bookmarkable).to eq(service.bookmarkable)
        expect(bookmark.user).to eq(service.user)
      end
    end
  end

  describe ".call" do
    context "when bookmarkable post" do
      let(:bookmarkable) { create(:post) }

      include_examples "bookmark exists"
      include_examples "bookmark does not exist"
    end

    context "when bookmarkable comment" do
      let(:bookmarkable) { create(:comment) }

      include_examples "bookmark exists"
      include_examples "bookmark does not exist"
    end
  end

  def build_create_bookmark_service(bookmarkable)
    user = create(:user)

    described_class.new(bookmarkable, user)
  end
end