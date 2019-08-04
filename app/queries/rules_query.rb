# frozen_string_literal: true

class RulesQuery
  attr_reader :relation

  def initialize(relation = Rule.all)
    @relation = relation
  end

  def global
    relation.where(sub: nil)
  end

  def sub(sub)
    relation.where(sub: sub)
  end
end