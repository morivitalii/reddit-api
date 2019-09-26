class RemoveDeletionReasonsUpdatedAtFromSubs < ActiveRecord::Migration[5.2]
  def change
    remove_column :subs, :deletion_reasons_updated_at, :datetime, null: false, default: -> { "now()::timestamp" }
  end
end
