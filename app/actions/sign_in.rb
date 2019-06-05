# frozen_string_literal: true

class SignIn
  include ActiveModel::Model

  attr_accessor :username, :password
  attr_reader :user

  validates :username, presence: true, username_format: true
  validates :password, presence: true, length: { minimum: 6, maximum: 16 }
  validate :authenticate, if: ->(record) { record.errors.blank? }

  def authenticate
    @user = User.where("lower(username) = ?", @username.downcase).take

    if @user.blank? || !@user.authenticate(@password)
      errors.add(:username, :invalid_credentials)
    end
  end
end
