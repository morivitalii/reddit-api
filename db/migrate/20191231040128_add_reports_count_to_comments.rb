class AddReportsCountToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :reports_count, :integer, null: false, default: 0
  end
end
