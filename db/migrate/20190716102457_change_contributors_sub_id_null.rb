class ChangeContributorsSubIdNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :contributors, :sub_id, true
  end
end
