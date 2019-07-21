class RemoveReportsCountFromThings < ActiveRecord::Migration[5.2]
  def change
    remove_column :things, :reports_count, :integer, null: false, default: 0
  end
end
