# frozen_string_literal: true

class PagesQuery
  attr_reader :relation

  def initialize(relation = Page.all)
    @relation = relation
  end

  def global
    relation.where(sub: nil)
  end

  def sub(sub)
    relation.where(sub: sub)
  end
end