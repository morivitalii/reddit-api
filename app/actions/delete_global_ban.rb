# frozen_string_literal: true

class DeleteGlobalBan
  def initialize(ban:, current_user:)
    @ban = ban
    @current_user = current_user
  end

  def call
    @ban.destroy!

    CreateLogJob.perform_later(
      current_user: @current_user,
      action: "delete_global_ban",
      loggable: @ban.user,
      model: @ban
    )
  end
end
