class RenameIndexOnCommunityIdAndUserIdInModerators < ActiveRecord::Migration[6.0]
  def change
    rename_index :follows, "index_moderators_on_community_id_and_user_id", "index_moderators_uniqueness"
  end
end
