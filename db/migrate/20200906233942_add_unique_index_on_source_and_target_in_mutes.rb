class AddUniqueIndexOnSourceAndTargetInMutes < ActiveRecord::Migration[6.0]
  def change
    add_index :mutes, [:source_type, :source_id, :target_type, :target_id], unique: true, name: :index_mutes_uniqueness
  end
end
