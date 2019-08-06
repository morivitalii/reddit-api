# frozen_string_literal: true

class UpdateUserForm
  include ActiveModel::Model

  attr_accessor :user, :email, :password, :password_current

  validates :email, allow_blank: true, email_format: true
  validate :email_unique
  validates :password, allow_blank: true, length: { minimum: 6, maximum: 16 }
  validates :password_current, presence: true, length: { minimum: 6, maximum: 16 }
  validate :current_password_match

  def save
    return false if invalid?

    attributes = { email: email }

    if password.present?
      attributes[:password] = password
    end

    @user.update!(attributes)
  end

  private

  def current_password_match
    unless current_password_match?
      errors.add(:password_current, :invalid_current_password)
    end
  end

  def email_unique
    unless email_unique?
      errors.add(:email, :email_taken)
    end
  end

  def email_unique?
    scope = UsersQuery.new.where_email(email)
    scope.where.not(id: user.id).exists?
  end

  def current_password_match?
    user.authenticate(password_current)
  end
end
