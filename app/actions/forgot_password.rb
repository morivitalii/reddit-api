# frozen_string_literal: true

class ForgotPassword
  include ActiveModel::Model

  attr_accessor :email

  validates :email, presence: true, email_format: true

  def save
    return false if invalid?

    user = UsersQuery.new.where_email(@email).take

    if user.present? && user.forgot_password_email_sent_at < 1.day.ago
      user.update!(forgot_password_email_sent_at: Time.current)

      ForgotPasswordMailer.with(email: user.email, token: user.forgot_password_token).forgot_password.deliver_later
    end

    # No matter if user with email exists or not, we always return successful result
    true
  end
end
