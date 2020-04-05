class ModeratorsQuery < ApplicationQuery
  def with_username(username)
    relation.joins(:user).where("lower(users.username) = lower(?)", username)
  end

  def recent(limit)
    relation.order(id: :asc).limit(limit)
  end
end
