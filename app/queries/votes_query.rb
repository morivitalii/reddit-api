# frozen_string_literal: true

class VotesQuery
  attr_reader :relation

  def initialize(relation = Vote.all)
    @relation = relation
  end

  def filter_by_votable_type(type)
    return relation if type.blank?

    relation.where(votable_type: type)
  end

  def filter_by_vote_type(type)
    return relation if type.blank?

    relation.where(vote_type: type)
  end

  def where_user(user)
    relation.where(user: user)
  end
end