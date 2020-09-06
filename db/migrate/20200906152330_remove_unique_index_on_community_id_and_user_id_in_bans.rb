class RemoveUniqueIndexOnCommunityIdAndUserIdInBans < ActiveRecord::Migration[6.0]
  def change
    remove_index :bans, column: [:community_id, :user_id], unique: true
  end
end
