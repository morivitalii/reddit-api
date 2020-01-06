class VotesQuery < ApplicationQuery
  def for_posts
    relation.where(votable_type: "Post")
  end

  def for_comments
    relation.where(votable_type: "Comment")
  end
end
