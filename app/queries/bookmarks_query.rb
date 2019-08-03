# frozen_string_literal: true

class BookmarksQuery
  attr_reader :relation

  def initialize(relation = Bookmark.all)
    @relation = relation
  end

  def filter_by_bookmarkable_type(type)
    return relation if type.blank?

    relation.where(bookmarkable_type: type)
  end

  def where_user(user)
    relation.where(user: user)
  end
end