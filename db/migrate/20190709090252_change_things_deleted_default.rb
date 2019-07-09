class ChangeThingsDeletedDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default :things, :deleted, from: nil, to: false
  end
end
