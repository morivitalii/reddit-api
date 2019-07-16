class ChangeTagsSubIdNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tags, :sub_id, true
  end
end
