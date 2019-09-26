# frozen_string_literal: true

class ChangePasswordForm
  include ActiveModel::Model

  attr_accessor :token, :password

  validates :token, presence: true
  validate :validate_token
  validates :password, presence: true

  def save
    return false if invalid?

    user.update!(password: password)
    user.regenerate_forgot_password_token
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end

  def user
    @_user ||= UsersQuery.new.with_forgot_password_token(token).take!
  end

  def persisted?
    true
  end

  private

  def validate_token
    unless UsersQuery.new.with_forgot_password_token(token).exists?
      errors.add(:password, :invalid_forgot_password_token)
    end
  end
end
