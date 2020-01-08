require "rails_helper"

RSpec.describe Communities::Posts::Comments::DeleteDownVote do
  describe ".call" do
    context "when user has no vote on comment" do
      it "does nothing to comment" do
        user = create(:user)
        comment = create(:comment)
        service = described_class.new(comment, user)

        expect(service.comment).to_not receive(:update_scores!)

        service.call

        expect(service.comment.votes.count).to eq(0)
        expect(service.comment.down_votes_count).to eq(0)
        expect(service.comment.up_votes_count).to eq(0)
      end
    end

    context "when user has up vote on comment" do
      it "does nothing to comment and does not delete up vote" do
        user = create(:user)
        comment = create(:comment_with_up_vote, voted_by: user)
        service = described_class.new(comment, user)

        expect(service.comment).to_not receive(:update_scores!)

        service.call

        expect(service.comment.votes.count).to eq(1)
        expect(service.comment.down_votes_count).to eq(0)
        expect(service.comment.up_votes_count).to eq(1)
      end
    end

    context "when user has down vote on comment" do
      it "deletes down vote, decrements comment down votes count and updates comment scores" do
        user = create(:user)
        comment = create(:comment_with_down_vote, voted_by: user)
        service = described_class.new(comment, user)

        expect(service.comment).to receive(:update_scores!)

        service.call

        expect(service.comment.votes.count).to eq(0)
        expect(service.comment.down_votes_count).to eq(0)
        expect(service.comment.up_votes_count).to eq(0)
      end
    end
  end
end
