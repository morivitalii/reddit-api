# frozen_string_literal: true

class DeleteBan
  def initialize(ban:, current_user:)
    @ban = ban
    @current_user = current_user
  end

  def call
    @ban.destroy!
  end
end
