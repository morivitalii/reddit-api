# frozen_string_literal: true

class UsersQuery < ApplicationQuery
  def with_forgot_password_token(token)
    relation.where(forgot_password_token: token)
  end

  def with_username(username)
    relation.where("lower(users.username) = lower(?)", username)
  end

  def with_email(email)
    relation.where("lower(users.email) = lower(?)", email)
  end

  def auto_moderator
    with_username("AutoModerator")
  end
end