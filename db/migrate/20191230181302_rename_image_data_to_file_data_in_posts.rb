class RenameImageDataToFileDataInPosts < ActiveRecord::Migration[6.0]
  def change
    rename_column :posts, :image_data, :file_data
  end
end
