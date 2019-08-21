class RenameRateLimitsKeyToAction < ActiveRecord::Migration[5.2]
  def change
    rename_column :rate_limits, :key, :action
  end
end
