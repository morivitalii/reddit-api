require "rails_helper"

RSpec.describe Comment do
  subject { described_class }

  it_behaves_like "paginatable"

  context "when author have permissions for approving" do
    it "approves comment on create" do
      comment = build(:comment)
      allow(comment).to receive(:author_has_permissions_to_approve?).and_return(true)

      comment.save!

      expect(comment.approved_by).to eq(comment.created_by)
      expect(comment.approved_at).to be_present
    end
  end

  context "when author have not permissions for approving" do
    it "does not approve comment on create" do
      comment = build(:comment)
      allow(comment).to receive(:author_has_permissions_to_approve?).and_return(false)

      comment.save!

      expect(comment.approved_by).to be_blank
      expect(comment.approved_at).to be_blank
    end
  end

  context "when comment is approved" do
    context "and when it is editing" do
      it "resets approved attributes" do
        comment = create(:approved_comment)
        allow(comment).to receive(:editing?).and_return(true)

        comment.save!

        expect(comment.approved_by).to be_blank
        expect(comment.approved_at).to be_blank
      end
    end

    context "and when it is not editing" do
      it "does not reset approved attributes" do
        comment = create(:approved_comment)
        allow(comment).to receive(:editing?).and_return(false)

        comment.save!

        expect(comment.approved_by).to be_present
        expect(comment.approved_at).to be_present
      end
    end

    context "and when it is removing" do
      it "resets approved attributes" do
        comment = create(:approved_comment)
        allow(comment).to receive(:removing?).and_return(true)

        comment.save!

        expect(comment.approved_by).to be_blank
        expect(comment.approved_at).to be_blank
      end
    end

    context "and when it is not removing" do
      it "does not reset approved attributes" do
        comment = create(:approved_comment)
        allow(comment).to receive(:removing?).and_return(false)

        comment.save!

        expect(comment.approved_by).to be_present
        expect(comment.approved_at).to be_present
      end
    end
  end

  context "when it is approving" do
    it "destroys reports" do
      comment = create(:comment_with_reports, reports_count: 2)
      allow(comment).to receive(:approving?).and_return(true)

      comment.save!

      expect(comment.reports).to be_blank
    end
  end

  context "when it is removing" do
    it "destroys reports" do
      comment = create(:comment_with_reports, reports_count: 2)
      allow(comment).to receive(:removing?).and_return(true)

      comment.save!

      expect(comment.reports).to be_blank
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

  describe ".removed?" do
    context "when comment is not removed" do
      it "returns false" do
        comment = build(:not_removed_comment)

        expect(comment).to_not be_removed
      end
    end

    context "when comment is removed" do
      it "returns true" do
        comment = build(:removed_comment)

        expect(comment).to be_removed
      end
    end
  end

  describe ".update_scores!" do
    it "updates comment scores" do
      comment = create(:comment)
      allow(comment).to receive(:update!)

      comment.update_scores!

      expect(comment).to have_received(:update!).with(
        new_score: anything,
        hot_score: anything,
        best_score: anything,
        top_score: anything,
        controversy_score: anything
      )
    end
  end
end
