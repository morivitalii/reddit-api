require "rails_helper"

RSpec.describe VotesQuery do
  subject { described_class }

  describe ".with_votable_type" do
    it "returns votes by given votable_type" do
      posts_votes = create_pair(:post_vote)
      _comments_votes = create_pair(:comment_vote)

      result = subject.new.with_votable_type("Post")

      expect(result).to match_array(posts_votes)
    end
  end

  describe ".search_by_vote_type" do
    it "return relation if type is blank" do
      query = subject.new

      result = query.search_by_vote_type("")

      expect(result).to eq(query.relation)
    end

    it "returns votes by given vote_type" do
      up_votes = create_pair(:up_vote)
      _down_votes = create_pair(:down_vote)

      result = subject.new.search_by_vote_type(:up)

      expect(result).to match_array(up_votes)
    end
  end
end
