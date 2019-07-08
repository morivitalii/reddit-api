# frozen_string_literal: true

class CreateBookmark
  def initialize(thing:, current_user:)
    @thing = thing
    @current_user = current_user
  end

  def call
    @thing.bookmarks.find_or_create_by!(user: @current_user)
  end
end
