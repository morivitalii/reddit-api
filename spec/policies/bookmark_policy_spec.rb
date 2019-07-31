require "rails_helper"

RSpec.describe BookmarkPolicy do
  let(:bookmark_class) { Bookmark }

  context "for visitor" do
    let(:user) { nil }
    let(:context) { UserContext.new(user) }

    permissions :index?, :comments? do
      it "denies access" do
        expect(described_class).to_not permit(context, bookmark_class)
      end
    end

    permissions :create?, :destroy? do
      it "denies access" do
        expect(described_class).to_not permit(context, bookmark_class)
      end
    end
  end

  context "for user" do
    let(:user) { create(:user) }
    let(:context) { UserContext.new(user) }

    permissions :index?, :comments? do
      it "grants access" do
        expect(described_class).to permit(context, bookmark_class)
      end
    end

    permissions :create?, :destroy? do
      it "grants access" do
        expect(described_class).to permit(context, bookmark_class)
      end
    end
  end
end