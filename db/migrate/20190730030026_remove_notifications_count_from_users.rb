class RemoveNotificationsCountFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :notifications_count, :integer, null: false, default: 0
  end
end
