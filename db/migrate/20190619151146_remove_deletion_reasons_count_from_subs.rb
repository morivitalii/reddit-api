class RemoveDeletionReasonsCountFromSubs < ActiveRecord::Migration[5.2]
  def change
    remove_column :subs, :deletion_reasons_count, :integer, null: false, default: 0
  end
end
