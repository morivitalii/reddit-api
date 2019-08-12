# frozen_string_literal: true

class ForgotPasswordForm
  include ActiveModel::Model

  attr_accessor :email

  validates :email, presence: true

  def save
    return false if invalid?

    send_email if user.present?

    # No matter if user with email exists or not, we always return successful result
    true
  end

  private

  def send_email
    email = user.email
    token = user.forgot_password_token

    ForgotPasswordMailer.with(email: email, token: token).forgot_password.deliver_now
  end

  def user
    @_user ||= UsersQuery.new.with_email(email).take
  end
end
