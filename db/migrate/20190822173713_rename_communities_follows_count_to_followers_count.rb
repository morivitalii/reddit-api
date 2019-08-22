class RenameCommunitiesFollowsCountToFollowersCount < ActiveRecord::Migration[5.2]
  def change
    rename_column :communities, :follows_count, :followers_count
  end
end
