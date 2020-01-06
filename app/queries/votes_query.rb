class VotesQuery < ApplicationQuery
  def up_votes
    relation.where(vote_type: :up)
  end

  def down_votes
    relation.where(vote_type: :down)
  end

  def for_posts
    relation.where(votable_type: "Post")
  end

  def for_comments
    relation.where(votable_type: "Comment")
  end
end
