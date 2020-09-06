class RemovePermanentFromBans < ActiveRecord::Migration[6.0]
  def change
    remove_column :bans, :permanent, :boolean, null: false, default: false
  end
end
