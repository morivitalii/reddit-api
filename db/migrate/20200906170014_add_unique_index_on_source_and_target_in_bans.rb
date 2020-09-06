class AddUniqueIndexOnSourceAndTargetInBans < ActiveRecord::Migration[6.0]
  def change
    add_index :bans, [:source_type, :source_id, :target_type, :target_id], unique: true, name: :index_bans_uniqueness
  end
end
