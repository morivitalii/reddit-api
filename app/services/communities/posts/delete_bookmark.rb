class Communities::Posts::DeleteBookmark
  include ActiveModel::Model

  attr_accessor :post, :user

  def call
    post.bookmarks.where(user: user).destroy_all
  end
end
