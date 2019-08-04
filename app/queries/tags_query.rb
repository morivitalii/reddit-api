# frozen_string_literal: true

class TagsQuery
  attr_reader :relation

  def initialize(relation = Tag.all)
    @relation = relation
  end

  def global
    relation.where(sub: nil)
  end

  def sub(sub)
    relation.where(sub: sub)
  end

  def global_or_sub(sub)
    sub_condition = relation.model.where(sub: sub)

    relation.where(sub: nil).or(sub_condition)
  end

  def filter_by_title(title)
    relation.where("lower(tags.title) = ?", title.downcase)
  end
end