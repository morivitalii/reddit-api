# frozen_string_literal: true

class DeleteBookmark
  def initialize(model, current_user)
    @model = model
    @current_user = current_user
  end

  def call
    @model.bookmarks.where(user: @current_user).destroy_all
  end
end
