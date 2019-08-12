# frozen_string_literal: true

class VotesQuery < ApplicationQuery
  def posts_votes
    relation.where(votable_type: "Post")
  end

  def comments_votes
    relation.where(votable_type: "Comment")
  end

  def search_by_vote_type(type)
    return relation if type.blank?

    relation.where(vote_type: type)
  end
end