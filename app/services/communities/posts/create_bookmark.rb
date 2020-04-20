class Communities::Posts::CreateBookmark
  include ActiveModel::Model

  attr_accessor :post, :user

  def call
    post.bookmarks.find_or_create_by!(user: user)
  end
end
