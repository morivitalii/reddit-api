class ChangeThingsDeletedNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :things, :deleted, false
  end
end
