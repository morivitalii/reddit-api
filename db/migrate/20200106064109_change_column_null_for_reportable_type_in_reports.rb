class ChangeColumnNullForReportableTypeInReports < ActiveRecord::Migration[6.0]
  def change
    change_column_null :reports, :reportable_type, false
  end
end
