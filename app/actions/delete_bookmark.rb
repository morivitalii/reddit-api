# frozen_string_literal: true

class DeleteBookmark
  def initialize(thing:, current_user:)
    @thing = thing
    @current_user = current_user
  end

  def call
    @thing.bookmarks.where(user: @current_user).destroy_all
  end
end
