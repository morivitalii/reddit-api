class RemoveUniquenessIndexFromBlacklistedDomainsOnLowerDomain < ActiveRecord::Migration[5.2]
  def up
    remove_index :blacklisted_domains, name: :index_blacklisted_domains_on_lower_domain
  end

  def down
    add_index :blacklisted_domains, "lower(domain)", unique: true
  end
end
