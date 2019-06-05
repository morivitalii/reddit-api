# frozen_string_literal: true

class NewPassword
  include ActiveModel::Model

  attr_accessor :token, :password
  attr_reader :user

  validates :token, presence: true
  validates :password, presence: true, length: { minimum: 6, maximum: 16 }
  validate :exists?, if: ->(record) { record.errors.blank? }

  def save!
    validate!

    @user = User.where(forgot_password_token: @token).take!

    @user.transaction do
      @user.update!(password: @password)
      @user.regenerate_forgot_password_token
    end
  end

  private

  def exists?
    unless User.exists?(forgot_password_token: @token)
      errors.add(:password, :invalid_reset_password_link)
    end
  end
end
