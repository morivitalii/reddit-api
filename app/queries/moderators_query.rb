# frozen_string_literal: true

class ModeratorsQuery
  attr_reader :relation

  def initialize(relation = Moderator.all)
    @relation = relation
  end

  def where_sub(sub)
    relation.where(sub: sub)
  end

  def where_global
    relation.where(sub: nil)
  end

  def where_global_or_sub(sub)
    sub_condition = relation.model.where(sub: sub)

    relation.where(sub: nil).or(sub_condition)
  end

  def filter_by_username(username)
    return relation if username.blank?

    relation.joins(:user).where("lower(users.username) = ?", username.downcase)
  end
end