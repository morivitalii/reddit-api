# frozen_string_literal: true

class CommunitiesQuery < ApplicationQuery
  def with_url(url)
    relation.where("lower(url) = ?", url.downcase)
  end

  def default
    with_url("all")
  end

  def with_user_moderator(user)
    relation.joins(:moderators).where(moderators: { user: user })
  end

  def with_user_follower(user)
    relation.joins(:follows).where(follows: { user: user })
  end
end