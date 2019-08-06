# frozen_string_literal: true

class SignUpForm
  include ActiveModel::Model

  attr_accessor :username, :email, :password
  attr_reader :user

  validates :username, presence: true, username_format: true, username_uniqueness: true
  validates :email, allow_blank: true, email_format: true, email_uniqueness: true
  validates :password, presence: true, length: { minimum: 6, maximum: 16 }

  def save
    return false if invalid?

    @user = User.create!(
      username: username,
      email: email,
      password: password
    )
  end
end
