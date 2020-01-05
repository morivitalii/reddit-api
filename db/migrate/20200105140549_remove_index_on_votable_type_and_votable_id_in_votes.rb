class RemoveIndexOnVotableTypeAndVotableIdInVotes < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    remove_index :votes, column: [:votable_type, :votable_id], algorithm: :concurrently
  end
end
