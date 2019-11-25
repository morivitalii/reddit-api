require "rails_helper"

RSpec.describe Communities::Posts::Comments::Votes::DeleteDownVoteService do
  describe ".call" do
    context "when user has no vote on comment" do
      it "does nothing to comment" do
        service = build_service

        expect(service.comment).to_not receive(:update_scores!)

        service.call

        expect(Vote.count).to eq(0)
        expect(service.comment.down_votes_count).to eq(0)
        expect(service.comment.up_votes_count).to eq(0)
      end
    end

    context "when user has up vote on comment" do
      it "does nothing to comment and does not delete up vote" do
        service = build_service_with_comment_up_vote

        expect(service.comment).to_not receive(:update_scores!)

        service.call

        expect(Vote.count).to eq(1)
        expect(service.comment.down_votes_count).to eq(0)
        expect(service.comment.up_votes_count).to eq(1)
      end
    end

    context "when user has down vote on comment" do
      it "deletes down vote, decrements comment down votes count and updates comment scores" do
        service = build_service_with_comment_down_vote

        expect(service.comment).to receive(:update_scores!)

        service.call

        expect(Vote.count).to eq(0)
        expect(service.comment.down_votes_count).to eq(0)
        expect(service.comment.up_votes_count).to eq(0)
      end
    end
  end

  def build_service
    user = create(:user)
    comment = create(:comment)

    described_class.new(comment, user)
  end

  def build_service_with_comment_up_vote
    user = create(:user)
    comment = create(:comment_with_up_vote, voted_by: user)

    described_class.new(comment, user)
  end

  def build_service_with_comment_down_vote
    user = create(:user)
    comment = create(:comment_with_down_vote, voted_by: user)

    described_class.new(comment, user)
  end
end
