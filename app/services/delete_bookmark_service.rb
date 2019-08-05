# frozen_string_literal: true

class DeleteBookmarkService
  attr_reader :bookmarkable, :user

  def initialize(bookmarkable, user)
    @bookmarkable = bookmarkable
    @user = user
  end

  def call
    Bookmark.where(bookmarkable: bookmarkable, user: user).destroy_all
  end
end
