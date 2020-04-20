class Communities::Posts::Comments::DeleteBookmark
  include ActiveModel::Model

  attr_accessor :comment, :user

  def call
    comment.bookmarks.where(user: user).destroy_all
  end
end
