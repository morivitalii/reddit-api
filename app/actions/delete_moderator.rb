# frozen_string_literal: true

class DeleteModerator
  def initialize(moderator:, current_user:)
    @moderator = moderator
    @current_user = current_user
  end

  def call
    @moderator.destroy!
  end
end
