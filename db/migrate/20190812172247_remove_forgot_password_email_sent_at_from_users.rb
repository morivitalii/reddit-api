class RemoveForgotPasswordEmailSentAtFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :forgot_password_email_sent_at, :datetime
  end
end
