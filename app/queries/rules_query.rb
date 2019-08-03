# frozen_string_literal: true

class RulesQuery
  attr_reader :relation

  def initialize(relation = Rule.all)
    @relation = relation
  end

  def where_global
    relation.where(sub: nil)
  end

  def where_sub(sub)
    relation.where(sub: sub)
  end
end