require "rails_helper"

RSpec.describe VotesQuery do
  subject { described_class }

  describe ".posts_votes" do
    it "returns posts votes" do
      posts_votes = create_pair(:post_vote)
      create_pair(:comment_vote)

      result = subject.new.posts_votes

      expect(result).to contain_exactly(*posts_votes)
    end
  end

  describe ".comments_votes" do
    it "returns comments votes" do
      comments_votes = create_pair(:comment_vote)
      create_pair(:post_vote)

      result = subject.new.comments_votes

      expect(result).to contain_exactly(*comments_votes)
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
      create_pair(:down_vote)

      result = subject.new.search_by_vote_type(:up)

      expect(result).to contain_exactly(*up_votes)
    end
  end
end