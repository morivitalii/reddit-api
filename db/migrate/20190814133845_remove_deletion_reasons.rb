class RemoveDeletionReasons < ActiveRecord::Migration[5.2]
  def up
    drop_table :deletion_reasons
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
