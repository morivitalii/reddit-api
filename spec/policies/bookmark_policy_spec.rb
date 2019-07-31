require "rails_helper"

RSpec.describe BookmarkPolicy do
  subject { described_class }

  let(:bookmark_class) { Bookmark }

  context "for visitor" do
    let(:user) { nil }
    let(:context) { UserContext.new(user) }

    permissions :index?, :comments? do
      it "denies access" do
        expect(subject).to_not permit(context, bookmark_class)
      end
    end

    permissions :create?, :destroy? do
      it "denies access" do
        expect(subject).to_not permit(context, bookmark_class)
      end
    end
  end

  context "for user" do
    let(:user) { create(:user) }
    let(:context) { UserContext.new(user) }

    permissions :index?, :comments? do
      it "grants access" do
        expect(subject).to permit(context, bookmark_class)
      end
    end

    permissions :create?, :destroy? do
      it "grants access" do
        expect(subject).to permit(context, bookmark_class)
      end
    end
  end
end