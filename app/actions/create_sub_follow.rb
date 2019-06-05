# frozen_string_literal: true

class CreateSubFollow
  def initialize(sub:, current_user:)
    @sub = sub
    @current_user = current_user
  end

  def call
    @sub.follows.find_or_create_by!(user: @current_user)
  end
end
