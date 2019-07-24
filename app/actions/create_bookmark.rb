# frozen_string_literal: true

class CreateBookmark
  def initialize(model, current_user)
    @model = model
    @current_user = current_user
  end

  def call
    @model.bookmarks.find_or_create_by!(user: @current_user)
  end
end
