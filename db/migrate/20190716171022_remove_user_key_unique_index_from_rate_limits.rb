class RemoveUserKeyUniqueIndexFromRateLimits < ActiveRecord::Migration[5.2]
  def change
    remove_index :rate_limits, column: [:user_id, :key], unique: true
    add_index :rate_limits, :key
  end
end
