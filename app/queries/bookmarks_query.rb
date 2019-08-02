# frozen_string_literal: true

class BookmarksQuery
  attr_reader :relation

  def initialize(relation = Bookmark.all)
    @relation = relation
  end

  def where_type(type)
    relation.where(bookmarkable_type: type)
  end

  def where_user(user)
    relation.where(user: user)
  end
end