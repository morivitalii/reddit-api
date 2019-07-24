class ChangeThingsReceiveNotificationsDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default :things, :receive_notifications, true
  end
end
