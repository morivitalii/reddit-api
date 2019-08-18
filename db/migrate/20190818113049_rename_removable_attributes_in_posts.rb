class RenameRemovableAttributesInPosts < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :deleted_at, :removed_at
    rename_column :posts, :deleted_by_id, :removed_by_id
    rename_column :posts, :deletion_reason, :removed_reason
  end
end
