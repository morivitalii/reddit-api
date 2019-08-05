require "rails_helper"

RSpec.describe CreateBookmarkService do
  subject { described_class.new(bookmarkable, user) }

  let(:user) { create(:user) }
  let(:bookmarkable) { create(:post) }

  describe ".call" do
    context "does not exist" do
      it "create new one" do
        expect { subject.call }.to change { Bookmark.count }.by(1)
      end

      it "return created" do
        result = subject.call

        expect(result).to be_instance_of(Bookmark)
        expect(result).to have_attributes(user: user, bookmarkable: bookmarkable)
      end
    end

    context "exists" do
      let!(:bookmark) { create(:bookmark, user: user, bookmarkable: bookmarkable) }

      it "does not create new one" do
        expect { subject.call }.to_not change { Bookmark.count }
      end

      it "returns existent" do
        expected_result = bookmark
        result = subject.call

        expect(result).to eq(expected_result)
      end
    end
  end
end