class RemoveIndexOnApprovedByIdInPosts < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    remove_index :posts, column: :approved_by_id, algorithm: :concurrently
  end
end
