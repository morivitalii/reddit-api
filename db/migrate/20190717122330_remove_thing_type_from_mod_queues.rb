class RemoveThingTypeFromModQueues < ActiveRecord::Migration[5.2]
  def change
    remove_index :mod_queues, column: :thing_type
    remove_column :mod_queues, :thing_type, :integer, null: false
  end
end
