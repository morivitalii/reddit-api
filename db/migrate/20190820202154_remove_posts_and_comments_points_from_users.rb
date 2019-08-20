class RemovePostsAndCommentsPointsFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :posts_points, :integer, null: false, default: 0
    remove_column :users, :comments_points, :integer, null: false, default: 0
  end
end
