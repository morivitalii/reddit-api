class RenameIndexOnReportableTypeAndReportableIdAndUserIdInReports < ActiveRecord::Migration[6.0]
  def change
    rename_index :reports, "index_reports_on_reportable_type_and_reportable_id_and_user_id", "index_reports_uniqueness"
  end
end
