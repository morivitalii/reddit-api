class Communities::Posts::Comments::DeleteBookmark
  attr_reader :comment, :user

  def initialize(comment, user)
    @comment = comment
    @user = user
  end

  def call
    comment.bookmarks.where(user: user).destroy_all
  end
end
