class RemoveIndexOnPostIdInTopics < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    remove_index :topics, column: :post_id, algorithm: :concurrently
  end
end
