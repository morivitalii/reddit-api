class MutesQuery < ApplicationQuery
  def with_username(username)
    relation.joins(:user).where("lower(users.username) = lower(?)", username)
  end

  def search_by_username(username)
    return relation if username.blank?

    with_username(username)
  end

  def stale
    relation.where("mutes.end_at < ?", Time.current)
  end
end
