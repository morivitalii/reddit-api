class RemoveQueueTypeFromModQueues < ActiveRecord::Migration[5.2]
  def change
    remove_index :mod_queues, column: :queue_type
    remove_column :mod_queues, :queue_type, :integer, null: false
  end
end
