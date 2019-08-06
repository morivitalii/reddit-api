# frozen_string_literal: true

class ChangePasswordForm
  include ActiveModel::Model

  attr_accessor :token, :password
  attr_reader :user

  validates :token, presence: true
  validates :password, presence: true, length: { minimum: 6, maximum: 16 }
  validate :exists?

  def save
    return false if invalid?

    @user = UsersQuery.new.where_forgot_password_token(token).take!

    @user.transaction do
      @user.update!(password: password)
      @user.regenerate_forgot_password_token
    end
  end

  private

  def exists?
    unless UsersQuery.new.where_forgot_password_token(token).exists?
      errors.add(:password, :invalid_reset_password_link)
    end
  end
end
