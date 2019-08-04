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

  def where_user_moderator(user)
    relation.joins(:moderators).where(moderators: { user: user })
  end

  def where_user_follower(user)
    relation.joins(:follows).where(follows: { user: user })
  end
end