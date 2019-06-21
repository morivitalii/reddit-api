# frozen_string_literal: true

class SignUp
  include ActiveModel::Model

  attr_accessor :username, :email, :password
  attr_reader :user

  validates :username, presence: true, username_format: true
  validates :email, allow_blank: true, email_format: true
  validates :password, presence: true, length: { minimum: 6, maximum: 16 }

  with_options if: ->(record) { record.errors.blank? } do
    validates :username, username_uniqueness: true
    validates :email, email_uniqueness: true, unless: ->(r) { r.email.blank? }
  end

  def save
    return false if invalid?

    @user = User.create!(username: @username, email: @email, password: @password)
  end
end
