# frozen_string_literal: true

class SignInForm
  include ActiveModel::Model

  attr_accessor :username, :password

  validate :authenticate

  def authenticate
    if user.blank? || !user.authenticate(password)
      errors.add(:username, :invalid_credentials)
    end
  end

  def user
    @_user ||= UsersQuery.new.with_username(username).take
  end
end
