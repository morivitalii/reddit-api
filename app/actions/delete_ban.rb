# frozen_string_literal: true

class DeleteBan
  def initialize(ban:, current_user:)
    @ban = ban
    @current_user = current_user
  end

  def call
    ActiveRecord::Base.transaction do
      @ban.destroy!

      CreateLog.new(
        sub: @ban.sub,
        current_user: @current_user,
        action: :delete_ban,
        loggable: @ban.user,
        attributes: [:reason, :days, :permanent],
        model: @ban
      ).call
    end
  end
end
