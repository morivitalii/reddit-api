class RenameIndexOnCommunityIdAndUserIdInFollows < ActiveRecord::Migration[6.0]
  def change
    rename_index :follows, "index_follows_on_community_id_and_user_id", "index_follows_uniqueness"
  end
end
