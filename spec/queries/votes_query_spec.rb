require "rails_helper"

RSpec.describe VotesQuery do
  subject { described_class.new }

  describe ".filter_by_votable_type" do
    let!(:post_votes) { [create(:post_vote)] }
    let!(:comment_votes) { [create(:comment_vote)] }

    it "returns all votes if votable type is blank" do
      expected_result = post_votes + comment_votes
      result = subject.filter_by_votable_type(nil).all

      expect(result).to eq(expected_result)
    end

    it "returns votes with given votable type" do
      expected_result = post_votes
      type = expected_result.first.votable_type
      result = subject.filter_by_votable_type(type).all

      expect(result).to eq(expected_result)
    end
  end

  describe ".filter_by_vote_type" do
    let!(:up_votes) { [create(:up_vote)] }
    let!(:down_votes) { [create(:down_vote)] }

    it "returns all votes if vote type is blank" do
      expected_result = up_votes + down_votes
      result = subject.filter_by_vote_type(nil).all

      expect(result).to eq(expected_result)
    end

    it "returns votes with given vote type" do
      expected_result = up_votes
      type = expected_result.first.vote_type
      result = subject.filter_by_vote_type(type).all

      expect(result).to eq(expected_result)
    end
  end

  describe ".where_user" do
    let!(:user) { create(:user) }
    let!(:user_votes) { [create(:vote, user: user)] }
    let!(:votes) { [create(:vote)] }

    it "returns votes of given user" do
      expected_result = user_votes
      result = subject.where_user(user).all

      expect(result).to eq(expected_result)
    end
  end
end