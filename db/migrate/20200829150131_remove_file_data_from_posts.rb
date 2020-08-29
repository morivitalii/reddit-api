class RemoveFileDataFromPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :file_data, :string
  end
end
