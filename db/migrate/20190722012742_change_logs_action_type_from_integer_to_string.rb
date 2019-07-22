class ChangeLogsActionTypeFromIntegerToString < ActiveRecord::Migration[5.2]
  def change
    remove_index :logs, column: :action
    remove_column :logs, :action, :integer, null: false
    add_column :logs, :action, :string, null: false
  end
end
