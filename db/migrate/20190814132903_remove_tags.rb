class RemoveTags < ActiveRecord::Migration[5.2]
  def up
    drop_table :tags
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
