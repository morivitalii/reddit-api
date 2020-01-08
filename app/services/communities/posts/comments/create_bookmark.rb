class Communities::Posts::Comments::CreateBookmark
  attr_reader :comment, :user

  def initialize(comment, user)
    @comment = comment
    @user = user
  end

  def call
    comment.bookmarks.find_or_create_by!(user: user)
  end
end
