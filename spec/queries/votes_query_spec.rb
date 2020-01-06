require "rails_helper"

RSpec.describe VotesQuery do
  subject { described_class }

  describe ".for_posts" do
    it "returns votes for posts" do
      votes_for_posts = create_pair(:post_vote)
      _votes_for_comments = create_pair(:comment_vote)

      result = subject.new.for_posts

      expect(result).to match_array(votes_for_posts)
    end
  end

  describe ".for_comments" do
    it "returns votes for comments" do
      votes_for_comments = create_pair(:comment_vote)
      _votes_for_posts = create_pair(:post_vote)

      result = subject.new.for_comments

      expect(result).to match_array(votes_for_comments)
    end
  end
end
