class AddIndexOnApprovedInThings < ActiveRecord::Migration[5.2]
  def change
    add_index :things, :approved
  end
end
