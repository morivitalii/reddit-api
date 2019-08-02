# frozen_string_literal: true

class BansQuery
  attr_reader :relation

  def initialize(relation = Ban.all)
    @relation = relation
  end

  def where_sub(sub = nil)
    relation.where(sub: sub)
  end

  def where_username(username = nil)
    return relation if username.blank?

    relation.joins(:user).where("lower(users.username) = ?", username.downcase)
  end
end