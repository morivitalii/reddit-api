require "rails_helper"

RSpec.describe Communities::Posts::CreateUpVote do
  describe ".call" do
    context "when user up vote post with existing up vote" do
      it "does nothing to post and does not create vote" do
        user = create(:user)
        post = create(:post_with_up_vote, voted_by: user)
        service = described_class.new(post, user)

        expect(service.post).to_not receive(:update_scores!)

        vote = service.call

        expect(vote).to be_up
        expect(service.post.votes.count).to eq(1)
        expect(service.post.up_votes_count).to eq(1)
        expect(service.post.down_votes_count).to eq(0)
      end
    end

    context "when user up vote post with existing down vote" do
      it "deletes down vote, creates up vote, decrement post down votes count, increments post up votes count and updates post scores" do
        user = create(:user)
        post = create(:post_with_down_vote, voted_by: user)
        service = described_class.new(post, user)

        expect(service.post).to receive(:update_scores!)

        vote = service.call

        expect(vote).to be_up
        expect(service.post.votes.count).to eq(1)
        expect(service.post.up_votes_count).to eq(1)
        expect(service.post.down_votes_count).to eq(0)
      end
    end

    context "when user up vote post without existing vote" do
      it "creates up vote, increments post up votes count and updates post scores" do
        user = create(:user)
        post = create(:post)
        service = described_class.new(post, user)

        expect(service.post).to receive(:update_scores!)

        vote = service.call

        expect(vote).to be_up
        expect(service.post.votes.count).to eq(1)
        expect(service.post.up_votes_count).to eq(1)
        expect(service.post.down_votes_count).to eq(0)
      end
    end
  end
end
