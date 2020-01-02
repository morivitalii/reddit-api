class RemoveUrlFromPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :url, :string
  end
end
