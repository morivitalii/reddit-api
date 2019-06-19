class RemoveRulesCountFromSubs < ActiveRecord::Migration[5.2]
  def change
    remove_column :subs, :rules_count, :integer, null: false, default: 0
  end
end
