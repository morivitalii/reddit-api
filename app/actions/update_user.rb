# frozen_string_literal: true

class UpdateUser
  include ActiveModel::Model

  attr_accessor :user, :email, :password, :password_current

  validates :email, allow_blank: true, email_format: true
  validates :password, allow_blank: true, length: { minimum: 6, maximum: 16 }
  validates :password_current, presence: true, length: { minimum: 6, maximum: 16 }

  with_options if: ->(record) { record.errors.blank? } do
    validate :email_unique?, unless: ->(r) { r.email.blank? }
    validate :current_password_match?
  end

  def save
    return false if invalid?

    @user.email = @email
    @user.password = @password if @password.present?
    @user.save!
  end

  private

  def current_password_match?
    unless @user.authenticate(@password_current)
      errors.add(:password_current, :invalid_current_password)
    end
  end

  def email_unique?
    if User.where.not(id: @user.id).where("lower(email) = ?", @email.downcase).exists?
      errors.add(:email, :email_taken)
    end
  end
end
