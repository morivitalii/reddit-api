class RenamePostsMediaToImage < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :media_data, :image_data
  end
end
