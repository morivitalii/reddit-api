class RemoveThingReferenceFromReports < ActiveRecord::Migration[5.2]
  def change
    remove_index :reports, column: [:user_id, :thing_id], unique: true
    remove_reference :reports, :thing, foreign_key: true, null: false
  end
end
