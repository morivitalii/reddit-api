class RemoveThingTypeFromBookmarks < ActiveRecord::Migration[5.2]
  def change
    remove_index :bookmarks, column: :thing_type
    remove_column :bookmarks, :thing_type, :integer, null: false
  end
end
