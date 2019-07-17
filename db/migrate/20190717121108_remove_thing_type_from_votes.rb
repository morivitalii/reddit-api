class RemoveThingTypeFromVotes < ActiveRecord::Migration[5.2]
  def change
    remove_index :votes, column: :thing_type
    remove_column :votes, :thing_type, :integer, null: false
  end
end
