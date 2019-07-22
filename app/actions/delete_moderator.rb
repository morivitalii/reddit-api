# frozen_string_literal: true

class DeleteModerator
  def initialize(moderator:, current_user:)
    @moderator = moderator
    @current_user = current_user
  end

  def call
    ActiveRecord::Base.transaction do
      @moderator.destroy!

      CreateLog.new(
        sub: @moderator.sub,
        current_user: @current_user,
        action: :delete_moderator,
        loggable: @moderator.user,
        model: @moderator
      ).call
    end
  end
end
