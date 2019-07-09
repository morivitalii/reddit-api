class ChangeModeratorsSubIdNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :moderators, :sub_id, true
  end
end
