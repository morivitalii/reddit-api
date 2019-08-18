# frozen_string_literal: true

class UpdateUserForm
  include ActiveModel::Model

  attr_accessor :user, :email, :password, :password_current

  validate :validate_current_password

  def save
    return false if invalid?

    user.update!(email: email, password: password)
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end

  private

  def validate_current_password
    unless current_password_match?
      errors.add(:password_current, :invalid_current_password)
    end
  end

  def current_password_match?
    user.authenticate(password_current)
  end
end
