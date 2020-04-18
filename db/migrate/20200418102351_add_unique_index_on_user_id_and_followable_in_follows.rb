class AddUniqueIndexOnUserIdAndFollowableInFollows < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    add_index :follows, [:user_id, :followable_type, :followable_id], unique: true, algorithm: :concurrently
  end
end
