class RemoveContributors < ActiveRecord::Migration[5.2]
  def up
    drop_table :contributors
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
