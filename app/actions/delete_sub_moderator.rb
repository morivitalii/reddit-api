# frozen_string_literal: true

class DeleteSubModerator
  def initialize(moderator:, current_user:)
    @moderator = moderator
    @current_user = current_user
  end

  def call
    @moderator.destroy!

    CreateLogJob.perform_later(
      sub: @moderator.sub,
      current_user: @current_user,
      action: "delete_sub_moderator",
      loggable: @moderator.user,
      model: @moderator
    )
  end
end
