class ChangeColumnNullForReportableIdInReports < ActiveRecord::Migration[6.0]
  def change
    change_column_null :reports, :reportable_id, false
  end
end
