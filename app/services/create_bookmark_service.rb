# frozen_string_literal: true

class CreateBookmarkService
  attr_reader :bookmarkable, :user

  def initialize(bookmarkable, user)
    @bookmarkable = bookmarkable
    @user = user
  end

  def call
    bookmark.present? ? bookmark : Bookmark.create!(bookmarkable: bookmarkable, user: user)
  end

  private

  def bookmark
    @_bookmark ||= Bookmark.where(bookmarkable: bookmarkable, user: user).take
  end
end
