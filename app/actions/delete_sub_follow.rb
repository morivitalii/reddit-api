# frozen_string_literal: true

class DeleteSubFollow
  def initialize(sub:, current_user:)
    @sub = sub
    @current_user = current_user
  end

  def call
    @sub.follows.where(user: @current_user).destroy_all
  end
end
