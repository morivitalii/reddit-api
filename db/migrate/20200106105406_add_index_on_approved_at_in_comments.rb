class AddIndexOnApprovedAtInComments < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    add_index :comments, :approved_at, algorithm: :concurrently
  end
end
