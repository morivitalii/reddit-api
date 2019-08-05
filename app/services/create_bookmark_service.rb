# frozen_string_literal: true

class CreateBookmarkService
  attr_reader :bookmarkable, :user

  def initialize(bookmarkable, user)
    @bookmarkable = bookmarkable
    @user = user
  end

  def call
    Bookmark.find_or_create_by!(bookmarkable: bookmarkable, user: user)
  end
end
