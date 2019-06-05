# frozen_string_literal: true

class DeleteSubBan
  def initialize(ban:, current_user:)
    @ban = ban
    @current_user = current_user
  end

  def call
    @ban.destroy!

    CreateLogJob.perform_later(
      sub: @ban.sub,
      current_user: @current_user,
      action: "delete_sub_ban",
      loggable: @ban.user,
      model: @ban
    )
  end
end
