# frozen_string_literal: true

class ChangePasswordForm
  include ActiveModel::Model

  attr_accessor :token, :password

  validates :token, presence: true
  validates :password, presence: true

  def save
    return false if invalid?

    user.update!(password: password)
    user.regenerate_forgot_password_token
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end

  def user
    @_user ||= UsersQuery.new.with_forgot_password_token(token).take!
  end
end
