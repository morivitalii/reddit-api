class RemoveSubReferenceFromModQueues < ActiveRecord::Migration[5.2]
  def change
    remove_reference :mod_queues, :sub, null: false, index: true
  end
end
