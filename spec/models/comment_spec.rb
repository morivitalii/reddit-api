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

  context "when it is removing" do
    it "destroys reports" do
      comment = create(:comment_with_reports, reports_count: 2)
      allow(comment).to receive(:removing?).and_return(true)

      comment.save!

      expect(comment.reports).to be_blank
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
