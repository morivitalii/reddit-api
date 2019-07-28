class ChangeCommentsParentIdNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :comments, :parent_id, true
  end
end
