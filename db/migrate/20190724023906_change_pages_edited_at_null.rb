class ChangePagesEditedAtNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :pages, :edited_by_id, true
  end
end
