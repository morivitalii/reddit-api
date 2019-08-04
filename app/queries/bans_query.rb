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
end