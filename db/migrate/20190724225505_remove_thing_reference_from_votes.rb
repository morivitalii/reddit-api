class RemoveThingReferenceFromVotes < ActiveRecord::Migration[5.2]
  def change
    remove_index :votes, column: [:user_id, :thing_id], unique: true
    remove_reference :votes, :thing, foreign_key: true, null: false
  end
end
