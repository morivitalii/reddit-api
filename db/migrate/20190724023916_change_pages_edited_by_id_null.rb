class ChangePagesEditedByIdNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :pages, :edited_at, true
  end
end
