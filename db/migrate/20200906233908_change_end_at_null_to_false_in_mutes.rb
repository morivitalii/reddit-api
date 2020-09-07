class ChangeEndAtNullToFalseInMutes < ActiveRecord::Migration[6.0]
  def change
    change_column_null :mutes, :end_at, false
  end
end
