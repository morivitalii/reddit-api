require "rails_helper"

RSpec.describe Post, type: :model do
  subject { described_class }

  it_behaves_like "paginatable"
  it_behaves_like "votable"
  it_behaves_like "reportable"
  it_behaves_like "markdownable", :text
  it_behaves_like "strip attributes", :title, :removed_reason, squish: true
  it_behaves_like "strip attributes", :text

  context "when author have permissions for approving" do
    it "approves post on create" do
      post = build(:post)
      allow(post).to receive(:author_has_permissions_to_approve?).and_return(true)

      post.save!

      expect(post.approved_by).to eq(post.user)
      expect(post.approved_at).to be_present
    end
  end

  context "when author have not permissions for approving" do
    it "does not approve post on create" do
      post = build(:post)
      allow(post).to receive(:author_has_permissions_to_approve?).and_return(false)

      post.save!

      expect(post.approved_by).to be_blank
      expect(post.approved_at).to be_blank
    end
  end

  context "when post is approved" do
    context "and when it is editing" do
      it "resets approved attributes" do
        post = create(:approved_post)
        allow(post).to receive(:editing?).and_return(true)

        post.save!

        expect(post.approved_by).to be_blank
        expect(post.approved_at).to be_blank
      end
    end

    context "and when it is not editing" do
      it "does not reset approved attributes" do
        post = create(:approved_post)
        allow(post).to receive(:editing?).and_return(false)

        post.save!

        expect(post.approved_by).to be_present
        expect(post.approved_at).to be_present
      end
    end

    context "and when it is removing" do
      it "resets approved attributes" do
        post = create(:approved_post)
        allow(post).to receive(:removing?).and_return(true)

        post.save!

        expect(post.approved_by).to be_blank
        expect(post.approved_at).to be_blank
      end
    end

    context "and when it is not removing" do
      it "does not reset approved attributes" do
        post = create(:approved_post)
        allow(post).to receive(:removing?).and_return(false)

        post.save!

        expect(post.approved_by).to be_present
        expect(post.approved_at).to be_present
      end
    end
  end

  describe ".approve!" do
    it "approves post" do
      post = create(:post)
      approved_by = create(:user)

      post.approve!(approved_by)

      expect(post.approved_by).to eq(approved_by)
      expect(post.approved_at).to be_present
    end
  end

  describe ".approved?" do
    context "when post is approved" do
      it "returns true" do
        post = build(:approved_post)

        expect(post).to be_approved
      end
    end

    context "when post is not approved" do
      it "returns false" do
        post = build(:not_approved_post)

        expect(post).to_not be_approved
      end
    end
  end

  describe ".edit" do
    it "edits post" do
      post = create(:post)
      edited_by = create(:user)

      post.edit(edited_by)
      post.save!

      expect(post.edited_by).to eq(edited_by)
      expect(post.edited_at).to be_present
    end
  end

  describe ".edited?" do
    context "when post is edited" do
      it "returns true" do
        post = build(:edited_post)

        expect(post).to be_edited
      end
    end

    context "when post is not edited" do
      it "returns false" do
        post = build(:not_edited_post)

        expect(post).to_not be_edited
      end
    end
  end

  describe ".remove" do
    it "removes post" do
      post = create(:post)
      removed_by = create(:user)
      reason = "Reason"

      post.remove!(removed_by, reason)

      expect(post.removed_by).to eq(removed_by)
      expect(post.removed_at).to be_present
      expect(post.removed_reason).to eq(reason)
    end
  end

  describe ".removed?" do
    context "when post is not removed" do
      it "returns false" do
        post = build(:not_removed_post)

        expect(post).to_not be_removed
      end
    end

    context "when post is removed" do
      it "returns true" do
        post = build(:removed_post)

        expect(post).to be_removed
      end
    end
  end
end