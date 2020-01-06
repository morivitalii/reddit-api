class AddIndexOnRemovedAtInComments < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    add_index :comments, :removed_at, algorithm: :concurrently
  end
end
