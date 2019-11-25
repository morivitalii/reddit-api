class Communities::Posts::DeleteBookmarkService
  attr_reader :post, :user

  def initialize(post, user)
    @post = post
    @user = user
  end

  def call
    post.bookmarks.where(user: user).destroy_all
  end
end