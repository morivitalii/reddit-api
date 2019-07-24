class RemoveDeletedFromThings < ActiveRecord::Migration[5.2]
  def change
    remove_column :things, :deleted, :boolean, index: true
  end
end
