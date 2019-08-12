# frozen_string_literal: true

class BookmarksQuery < ApplicationQuery
  def posts_bookmarks
    relation.where(bookmarkable_type: "Post")
  end

  def comments_bookmarks
    relation.where(bookmarkable_type: "Comment")
  end
end