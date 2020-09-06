class RemoveDaysFromBans < ActiveRecord::Migration[6.0]
  def change
    remove_column :bans, :days, :integer
  end
end
