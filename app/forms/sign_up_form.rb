# frozen_string_literal: true

class SignUpForm
  include ActiveModel::Model

  attr_accessor :username, :email, :password
  attr_reader :user

  def save
    @user = User.create!(
      username: username,
      email: email,
      password: password
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end

  def persisted?
    false
  end
end
