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
