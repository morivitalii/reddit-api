class RemoveApprovedFromThings < ActiveRecord::Migration[5.2]
  def change
    remove_column :things, :approved, :boolean, null: false, default: false
  end
end
