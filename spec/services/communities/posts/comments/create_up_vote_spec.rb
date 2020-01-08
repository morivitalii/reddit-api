require "rails_helper"

RSpec.describe Communities::Posts::Comments::CreateUpVote do
  describe ".call" do
    context "when user up vote comment with existing up vote" do
      it "does nothing to comment and does not create vote" do
        user = create(:user)
        comment = create(:comment_with_up_vote, voted_by: user)
        service = described_class.new(comment, user)

        expect(service.comment).to_not receive(:update_scores!)

        vote = service.call

        expect(vote).to be_up
        expect(service.comment.votes.count).to eq(1)
        expect(service.comment.up_votes_count).to eq(1)
        expect(service.comment.down_votes_count).to eq(0)
      end
    end

    context "when user up vote comment with existing down vote" do
      it "deletes down vote, creates up vote, decrement comment down votes count, increments comment up votes count and updates comment scores" do
        user = create(:user)
        comment = create(:comment_with_down_vote, voted_by: user)
        service = described_class.new(comment, user)

        expect(service.comment).to receive(:update_scores!)

        vote = service.call

        expect(vote).to be_up
        expect(service.comment.votes.count).to eq(1)
        expect(service.comment.up_votes_count).to eq(1)
        expect(service.comment.down_votes_count).to eq(0)
      end
    end

    context "when user up vote comment without existing vote" do
      it "creates up vote, increments comment up votes count and updates comment scores" do
        user = create(:user)
        comment = create(:comment)
        service = described_class.new(comment, user)

        expect(service.comment).to receive(:update_scores!)

        vote = service.call

        expect(vote).to be_up
        expect(service.comment.votes.count).to eq(1)
        expect(service.comment.up_votes_count).to eq(1)
        expect(service.comment.down_votes_count).to eq(0)
      end
    end
  end
end
