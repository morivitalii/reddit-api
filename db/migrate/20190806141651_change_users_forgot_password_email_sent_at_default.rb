class ChangeUsersForgotPasswordEmailSentAtDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :forgot_password_email_sent_at, nil
  end
end
