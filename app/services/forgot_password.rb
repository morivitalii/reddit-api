class ForgotPassword
  include ActiveModel::Model

  attr_accessor :email

  validates :email, presence: true

  def call
    return false if invalid?

    if user.present?
      email = user.email
      token = user.forgot_password_token

      ForgotPasswordMailer.with(email: email, token: token).forgot_password.deliver_later
    end

    # No matter if user with email exists or not, we always return successful result
    true
  end

  private

  def user
    @_user ||= UsersQuery.new.with_email(email).take
  end
end
