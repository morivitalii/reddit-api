require "rails_helper"

RSpec.describe Communities::Posts::Comments::CreateDownVote do
  describe ".call" do
    context "when user down vote comment with existing down vote" do
      it "does nothing to comment and does not create vote" do
        user = create(:user)
        comment = create(:comment_with_down_vote, voted_by: user)
        service = described_class.new(comment, user)

        expect(service.comment).to_not receive(:update_scores!)

        vote = service.call

        expect(vote).to be_down
        expect(service.comment.votes.count).to eq(1)
        expect(service.comment.down_votes_count).to eq(1)
        expect(service.comment.up_votes_count).to eq(0)
      end
    end

    context "when user down vote comment with existing up vote" do
      it "deletes up vote, creates down vote, decrement comment up votes count, increments comment down votes count and updates comment scores" do
        user = create(:user)
        comment = create(:comment_with_up_vote, voted_by: user)
        service = described_class.new(comment, user)

        expect(service.comment).to receive(:update_scores!)

        vote = service.call

        expect(vote).to be_down
        expect(service.comment.votes.count).to eq(1)
        expect(service.comment.down_votes_count).to eq(1)
        expect(service.comment.up_votes_count).to eq(0)
      end
    end

    context "when user down vote comment without existing vote" do
      it "creates down vote, increments comment down votes count and updates comment scores" do
        user = create(:user)
        comment = create(:comment)
        service = described_class.new(comment, user)

        expect(service.comment).to receive(:update_scores!)

        vote = service.call

        expect(vote).to be_down
        expect(service.comment.votes.count).to eq(1)
        expect(service.comment.down_votes_count).to eq(1)
        expect(service.comment.up_votes_count).to eq(0)
      end
    end
  end
end
