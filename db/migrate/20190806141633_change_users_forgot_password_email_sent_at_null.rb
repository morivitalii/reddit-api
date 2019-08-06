class ChangeUsersForgotPasswordEmailSentAtNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :forgot_password_email_sent_at, true
  end
end
