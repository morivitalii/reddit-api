class RemoveIndexOnCommentIdInComments < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    remove_index :comments, column: :comment_id, algorithm: :concurrently
  end
end
