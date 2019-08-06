# frozen_string_literal: true

class BansQuery
  attr_reader :relation

  def initialize(relation = Ban.all)
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

  def user_global_ban(user)
    relation.where(user: user, sub: nil)
  end

  def user_sub_ban(user, sub)
    relation.where(user: user, sub: sub)
  end

  def filter_by_username(username)
    return relation if username.blank?

    relation.joins(:user).where("lower(users.username) = ?", username.downcase)
  end

  def stale
    relation.where("end_at < ?", Time.current)
  end
end