class AddEditedByToThings < ActiveRecord::Migration[5.2]
  def change
    add_reference :things, :edited_by, foreign_key: { to_table: :users }
  end
end
