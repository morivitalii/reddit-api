# frozen_string_literal: true

class DeletionReasonsQuery
  attr_reader :relation

  def initialize(relation = DeletionReason.all)
    @relation = relation
  end

  def where_global
    relation.where(sub: nil)
  end

  def where_sub(sub)
    relation.where(sub: sub)
  end

  def where_global_or_sub(sub)
    sub_condition = relation.model.where(sub: sub)

    relation.where(sub: nil).or(sub_condition)
  end
end