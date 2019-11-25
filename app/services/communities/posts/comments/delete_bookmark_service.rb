class Communities::Posts::Comments::DeleteBookmarkService
  attr_reader :comment, :user

  def initialize(comment, user)
    @comment = comment
    @user = user
  end

  def call
    comment.bookmarks.where(user: user).destroy_all
  end
end
