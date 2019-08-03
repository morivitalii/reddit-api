# frozen_string_literal: true

class SubsQuery
  attr_reader :relation

  def initialize(relation = Sub.all)
    @relation = relation
  end

  def where_url(url)
    relation.where("lower(url) = ?", url.downcase)
  end

  def default
    where_url("all")
  end
end