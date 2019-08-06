# frozen_string_literal: true

class SignInForm
  include ActiveModel::Model

  attr_accessor :username, :password

  validates :username, presence: true, username_format: true
  validates :password, presence: true, length: { minimum: 6, maximum: 16 }
  validate :authenticate, if: ->(record) { record.errors.blank? }

  def authenticate
    if user.blank? || !user.authenticate(password)
      errors.add(:username, :invalid_credentials)
    end
  end

  def user
    @_user ||= UsersQuery.new.where_username(username).take
  end
end
