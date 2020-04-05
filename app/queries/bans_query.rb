class BansQuery < ApplicationQuery
  def with_username(username)
    relation.joins(:user).where("lower(users.username) = lower(?)", username)
  end

  def stale
    relation.where("bans.end_at < ?", Time.current)
  end
end
