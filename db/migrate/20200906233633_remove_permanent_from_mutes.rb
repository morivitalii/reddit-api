class RemovePermanentFromMutes < ActiveRecord::Migration[6.0]
  def change
    remove_column :mutes, :permanent, :boolean, null: false, default: false
  end
end
