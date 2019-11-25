require "rails_helper"

RSpec.describe Communities::Posts::Votes::DeleteDownVoteService do
  describe ".call" do
    context "when user has no vote on post" do
      it "does nothing to post" do
        service = build_service

        expect(service.post).to_not receive(:update_scores!)

        service.call

        expect(Vote.count).to eq(0)
        expect(service.post.down_votes_count).to eq(0)
        expect(service.post.up_votes_count).to eq(0)
      end
    end

    context "when user has up vote on post" do
      it "does nothing to post and does not delete up vote" do
        service = build_service_with_post_up_vote

        expect(service.post).to_not receive(:update_scores!)

        service.call

        expect(Vote.count).to eq(1)
        expect(service.post.down_votes_count).to eq(0)
        expect(service.post.up_votes_count).to eq(1)
      end
    end

    context "when user has down vote on post" do
      it "deletes down vote, decrements post down votes count and updates post scores" do
        service = build_service_with_post_down_vote

        expect(service.post).to receive(:update_scores!)

        service.call

        expect(Vote.count).to eq(0)
        expect(service.post.down_votes_count).to eq(0)
        expect(service.post.up_votes_count).to eq(0)
      end
    end
  end

  def build_service
    user = create(:user)
    post = create(:post)

    described_class.new(post, user)
  end

  def build_service_with_post_up_vote
    user = create(:user)
    post = create(:post_with_up_vote, voted_by: user)

    described_class.new(post, user)
  end

  def build_service_with_post_down_vote
    user = create(:user)
    post = create(:post_with_down_vote, voted_by: user)

    described_class.new(post, user)
  end
end
