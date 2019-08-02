# frozen_string_literal: true

class BansQuery
  attr_reader :relation

  def initialize(relation = Ban.all)
    @relation = relation
  end

  def where_global
    relation.where(sub: nil)
  end

  def where_sub(sub)
    relation.where(sub: sub)
  end

  def filter_by_username(username)
    return relation if username.blank?

    relation.joins(:user).where("lower(users.username) = ?", username.downcase)
  end
end