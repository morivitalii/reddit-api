class RemoveIndexOnPostIdInComments < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    remove_index :comments, column: :post_id, algorithm: :concurrently
  end
end
