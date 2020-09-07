class RemoveUniqueIndexOnCommunityIdAndUserIdMutes < ActiveRecord::Migration[6.0]
  def change
    remove_index :mutes, column: [:community_id, :user_id], unique: true
  end
end
