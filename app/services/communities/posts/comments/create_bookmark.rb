class Communities::Posts::Comments::CreateBookmark
  include ActiveModel::Model

  attr_accessor :comment, :user

  def call
    comment.bookmarks.find_or_create_by!(user: user)
  end
end
