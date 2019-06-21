# frozen_string_literal: true

class ForgotPassword
  include ActiveModel::Model

  attr_accessor :email

  validates :email, presence: true, email_format: true

  def save
    return false if invalid?

    user = User.where("lower(email) = ?", @email.downcase).take

    if user.present? && user.forgot_password_email_sent_at < 1.day.ago
      user.update!(forgot_password_email_sent_at: Time.current)

      ForgotPasswordMailer.with(email: user.email, token: user.forgot_password_token).forgot_password.deliver_later
    end
  end
end
