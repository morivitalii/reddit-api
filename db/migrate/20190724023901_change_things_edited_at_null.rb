class ChangeThingsEditedAtNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :things, :edited_at, true
  end
end
