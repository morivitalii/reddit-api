class DropNotifications < ActiveRecord::Migration[5.2]
  def up
    drop_table :notifications
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
