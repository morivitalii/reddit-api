class AddDeletedByToThings < ActiveRecord::Migration[5.2]
  def change
    add_reference :things, :deleted_by, foreign_key: {to_table: :users}, null: true
  end
end
