class BookmarksQuery < ApplicationQuery
  def for_posts
    relation.where(bookmarkable_type: "Post")
  end

  def for_comments
    relation.where(bookmarkable_type: "Comment")
  end
end
