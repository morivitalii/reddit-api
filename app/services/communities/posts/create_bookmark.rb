class Communities::Posts::CreateBookmark
  attr_reader :post, :user

  def initialize(post, user)
    @post = post
    @user = user
  end

  def call
    post.bookmarks.find_or_create_by!(user: user)
  end
end
