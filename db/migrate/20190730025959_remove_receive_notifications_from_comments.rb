class RemoveReceiveNotificationsFromComments < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :receive_notifications, :boolean, null: false, default: true
  end
end
