class ChangeEndAtNullToFalseInBans < ActiveRecord::Migration[6.0]
  def change
    change_column_null :bans, :end_at, false
  end
end
