class RemoveMasterFromModerators < ActiveRecord::Migration[5.2]
  def change
    remove_column :moderators, :master, :boolean, null: false, default: false
  end
end
