class ChangeColumnNullForCreatedAtInBans < ActiveRecord::Migration[6.0]
  def change
    change_column_null :bans, :created_at, false
  end
end
