require "rails_helper"

RSpec.describe CreateBookmarkService do
  subject { described_class }

  describe ".call" do
    let(:user) { create(:user) }
    let(:bookmarkable) { create(:post) }

    before do
      @service = subject.new(bookmarkable, user)
    end

    context "does not exist" do
      it "create new one" do
        expect { @service.call }.to change { Bookmark.count }.by(1)
      end

      it "return created" do
        result = @service.call

        expect(result).to be_instance_of(Bookmark)
        expect(result).to have_attributes(user: user, bookmarkable: bookmarkable)
      end
    end

    context "exists" do
      let!(:bookmark) { create(:bookmark, user: user, bookmarkable: bookmarkable) }

      it "does not create new one" do
        expect { @service.call }.to_not change { Bookmark.count }
      end

      it "returns existent" do
        result = @service.call

        expect(result).to eq(bookmark)
      end
    end
  end
end