class RemoveIndexOnEditedByIdInComments < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    remove_index :comments, column: :edited_by_id, algorithm: :concurrently
  end
end
