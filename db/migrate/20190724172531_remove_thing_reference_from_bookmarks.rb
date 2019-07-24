class RemoveThingReferenceFromBookmarks < ActiveRecord::Migration[5.2]
  def change
    remove_index :bookmarks, column: [:user_id, :thing_id], unique: true
    remove_reference :bookmarks, :thing, foreign_key: true, null: false
  end
end
