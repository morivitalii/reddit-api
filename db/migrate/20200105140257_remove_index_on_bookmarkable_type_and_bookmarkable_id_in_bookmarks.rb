class RemoveIndexOnBookmarkableTypeAndBookmarkableIdInBookmarks < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    remove_index :bookmarks, column: [:bookmarkable_type, :bookmarkable_id], algorithm: :concurrently
  end
end
