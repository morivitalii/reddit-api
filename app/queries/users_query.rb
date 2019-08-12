# frozen_string_literal: true

class UsersQuery < ApplicationQuery
  def with_forgot_password_token(token)
    relation.where(forgot_password_token: token)
  end

  def with_username(username)
    relation.where("lower(users.username) = ?", username.downcase)
  end

  def with_email(email)
    relation.where("lower(users.email) = ?", email.downcase)
  end

  def auto_moderator
    with_username("AutoModerator")
  end
end