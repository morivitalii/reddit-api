class DropThingsTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :things
  end
end
