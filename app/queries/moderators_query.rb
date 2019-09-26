# frozen_string_literal: true

class ModeratorsQuery < ApplicationQuery
  def with_username(username)
    relation.joins(:user).where("lower(users.username) = lower(?)", username)
  end

  def search_by_username(username)
    return relation if username.blank?

    with_username(username)
  end

  def recent(limit)
    relation.order(id: :asc).limit(limit)
  end
end
