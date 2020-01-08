require "rails_helper"

RSpec.describe Communities::Posts::DeleteDownVote do
  describe ".call" do
    context "when user has no vote on post" do
      it "does nothing to post" do
        user = create(:user)
        post = create(:post)
        service = described_class.new(post, user)

        expect(service.post).to_not receive(:update_scores!)

        service.call

        expect(service.post.votes.count).to eq(0)
        expect(service.post.down_votes_count).to eq(0)
        expect(service.post.up_votes_count).to eq(0)
      end
    end

    context "when user has up vote on post" do
      it "does nothing to post and does not delete up vote" do
        user = create(:user)
        post = create(:post_with_up_vote, voted_by: user)
        service = described_class.new(post, user)

        expect(service.post).to_not receive(:update_scores!)

        service.call

        expect(service.post.votes.count).to eq(1)
        expect(service.post.down_votes_count).to eq(0)
        expect(service.post.up_votes_count).to eq(1)
      end
    end

    context "when user has down vote on post" do
      it "deletes down vote, decrements post down votes count and updates post scores" do
        user = create(:user)
        post = create(:post_with_down_vote, voted_by: user)
        service = described_class.new(post, user)

        expect(service.post).to receive(:update_scores!)

        service.call

        expect(service.post.votes.count).to eq(0)
        expect(service.post.down_votes_count).to eq(0)
        expect(service.post.up_votes_count).to eq(0)
      end
    end
  end
end
