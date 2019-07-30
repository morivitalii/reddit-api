class RemoveReceiveNotificationsFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :receive_notifications, :boolean, null: false, default: true
  end
end
