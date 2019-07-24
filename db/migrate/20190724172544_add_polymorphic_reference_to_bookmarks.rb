class AddPolymorphicReferenceToBookmarks < ActiveRecord::Migration[5.2]
  def change
    add_reference :bookmarks, :bookmarkable, polymorphic: true, null: false
    add_index :bookmarks, [:bookmarkable_id, :bookmarkable_type, :user_id], unique: true, name: :index_bookmarks_uniqueness
  end
end
