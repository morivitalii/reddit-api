# frozen_string_literal: true

class BookmarksQuery < ApplicationQuery
  def with_bookmarkable_type(type)
    relation.where(bookmarkable_type: type)
  end
end