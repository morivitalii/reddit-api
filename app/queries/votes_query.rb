# frozen_string_literal: true

class VotesQuery < ApplicationQuery
  def with_votable_type(type)
    relation.where(votable_type: type)
  end

  def search_by_vote_type(type)
    return relation if type.blank?

    relation.where(vote_type: type)
  end
end