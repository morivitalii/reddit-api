class RemoveBlacklistedDomains < ActiveRecord::Migration[5.2]
  def up
    drop_table :blacklisted_domains
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
