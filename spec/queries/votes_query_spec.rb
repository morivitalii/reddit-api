require "rails_helper"

RSpec.describe VotesQuery do
  subject { described_class }

  describe ".posts_votes" do
    let!(:expected) { create_pair(:post_vote) }
    let!(:others) { create_pair(:comment_vote) }

    it "returns posts votes" do
      result = subject.new.posts_votes

      expect(result).to contain_exactly(*expected)
    end
  end

  describe ".comments_votes" do
    let!(:expected) { create_pair(:comment_vote) }
    let!(:others) { create_pair(:post_vote) }

    it "returns posts votes" do
      result = subject.new.comments_votes

      expect(result).to contain_exactly(*expected)
    end
  end

  describe ".search_by_vote_type" do
    let!(:expected) { create_pair(:up_vote) }
    let!(:others) { create_pair(:down_vote) }

    it "return relation if type is blank" do
      query = subject.new

      expected_result = query.relation
      result = query.search_by_vote_type("")

      expect(result).to eq(expected_result)
    end

    it "returns results filtered by vote_type" do
      result = subject.new.search_by_vote_type(:up)

      expect(result).to contain_exactly(*expected)
    end
  end
end