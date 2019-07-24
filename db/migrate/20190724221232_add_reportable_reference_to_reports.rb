class AddReportableReferenceToReports < ActiveRecord::Migration[5.2]
  def change
    add_reference :reports, :reportable, polymorphic: true, null: quoted_false
    add_index :reports, [:reportable_type, :reportable_id, :user_id], unique: true
  end
end
