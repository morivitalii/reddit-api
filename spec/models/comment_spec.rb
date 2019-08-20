require "rails_helper"

RSpec.describe Comment, type: :model do
  subject { described_class }

  it_behaves_like "paginatable"
  it_behaves_like "votable"
  it_behaves_like "removable"
  it_behaves_like "reportable"
  it_behaves_like "markdownable", :text
  it_behaves_like "strip attributes", :text

  context "when author have permissions for approving" do
    it "approves comment on create" do
      comment = build(:comment)
      allow(comment).to receive(:auto_approve?).and_return(true)

      comment.save!

      expect(comment.approved_by).to eq(comment.user)
      expect(comment.approved_at).to be_present
    end
  end

  context "when author have not permissions for approving" do
    it "does not approve comment on create" do
      comment = build(:comment)
      allow(comment).to receive(:auto_approve?).and_return(false)

      comment.save!

      expect(comment.approved_by).to be_blank
      expect(comment.approved_at).to be_blank
    end
  end

  describe "when comment approved" do
    context "and when it is editing" do
      it "resets approved attributes on update" do
        comment = create(:approved_comment)
        allow(comment).to receive(:editing?).and_return(true)

        comment.save!

        expect(comment.approved_by).to be_blank
        expect(comment.approved_at).to be_blank
      end
    end

    context "and when it is not editing" do
      it "does not reset approved attributes on update" do
        comment = create(:approved_comment)
        allow(comment).to receive(:editing?).and_return(false)

        comment.save!

        expect(comment.approved_by).to be_present
        expect(comment.approved_at).to be_present
      end
    end
  end

  describe ".approve!" do
    it "approves comment" do
      comment = create(:comment)
      approved_by = create(:user)

      comment.approve!(approved_by)

      expect(comment.approved_by).to eq(approved_by)
      expect(comment.approved_at).to be_present
    end
  end

  describe ".approved?" do
    context "when comment is approved" do
      it "returns true" do
        comment = build(:approved_comment)

        expect(comment).to be_approved
      end
    end

    context "when comment is not approved" do
      it "returns false" do
        comment = build(:not_approved_comment)

        expect(comment).to_not be_approved
      end
    end
  end

  describe ".edit" do
    it "edits comment" do
      comment = create(:comment)
      edited_by = create(:user)

      comment.edit(edited_by)
      comment.save!

      expect(comment.edited_by).to eq(edited_by)
      expect(comment.edited_at).to be_present
    end
  end

  describe ".edited?" do
    context "when comment is edited" do
      it "returns true" do
        comment = build(:edited_comment)

        expect(comment).to be_edited
      end
    end

    context "when comment is not edited" do
      it "returns false" do
        comment = build(:not_edited_comment)

        expect(comment).to_not be_edited
      end
    end
  end
end