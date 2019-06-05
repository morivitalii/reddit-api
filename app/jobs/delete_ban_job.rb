# frozen_string_literal: true

class DeleteBanJob < ApplicationJob
  queue_as :low_priority

  def perform(id)
    DeleteBan.new(ban: Ban.find(id), current_user: User.auto_moderator).call
  end
end
