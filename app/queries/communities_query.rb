class CommunitiesQuery < ApplicationQuery
  def with_url(url)
    relation.where("lower(communities.url) = lower(?)", url)
  end

  def with_user_moderator(user)
    relation.joins(:moderators).where(moderators: {user: user})
  end

  def with_user_follower(user)
    relation.joins(:follows).where(follows: {user: user})
  end

  def with_user_banned(user)
    relation.joins(:bans).where(bans: {target: user})
  end
end
