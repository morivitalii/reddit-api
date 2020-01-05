class RemoveIndexOnCommunityIdInFollows < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    remove_index :follows, column: :community_id, algorithm: :concurrently
  end
end
