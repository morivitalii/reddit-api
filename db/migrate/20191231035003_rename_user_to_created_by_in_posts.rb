class RenameUserToCreatedByInPosts < ActiveRecord::Migration[6.0]
  def change
    rename_column :posts, :user_id, :created_by_id
  end
end
