class DropLogs < ActiveRecord::Migration[5.2]
  def change
    drop_table :logs
  end
end
