# frozen_string_literal: true

class UsersQuery
  attr_reader :relation

  def initialize(relation = User.all)
    @relation = relation
  end

  def where_forgot_password_token(token)
    relation.where(forgot_password_token: token)
  end

  def where_username(username)
    relation.where("lower(users.username) = ?", username.downcase)
  end

  def where_email(email)
    relation.where("lower(users.email) = ?", email.downcase)
  end
end