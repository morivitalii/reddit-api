require "rails_helper"

RSpec.describe Comment do
  subject { described_class }

  it_behaves_like "paginatable"

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
