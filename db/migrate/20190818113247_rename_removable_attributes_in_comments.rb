class RenameRemovableAttributesInComments < ActiveRecord::Migration[5.2]
  def change
    rename_column :comments, :deleted_at, :removed_at
    rename_column :comments, :deleted_by_id, :removed_by_id
    rename_column :comments, :deletion_reason, :removed_reason
  end
end
