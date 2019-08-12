# frozen_string_literal: true

class ForgotPasswordForm
  include ActiveModel::Model

  attr_accessor :email

  validates :email, presence: true, email_format: true

  def save
    return false if invalid?

    if user.present? && !email_was_sent_today?
      user.update!(forgot_password_email_sent_at: Time.current)
      send_email
    end

    # No matter if user with email exists or not, we always return successful result
    true
  end

  private

  def user
    @_user ||= UsersQuery.new.with_email(email).take
  end

  def email_was_sent_today?
    sent_at = user.forgot_password_email_sent_at
    sent_at.present? && sent_at < 1.day.ago
  end

  def send_email
    email = user.email
    token = user.forgot_password_token

    ForgotPasswordMailer.with(email: email, token: token).forgot_password.deliver_now
  end
end
