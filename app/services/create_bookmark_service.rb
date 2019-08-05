# frozen_string_literal: true

class CreateBookmarkService
  attr_reader :bookmarkable, :user

  def initialize(bookmarkable, user)
    @bookmarkable = bookmarkable
    @user = user
  end

  def call
    bookmarkable.bookmarks.find_or_create_by!(user: user)
  end
end
