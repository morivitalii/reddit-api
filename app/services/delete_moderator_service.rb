# frozen_string_literal: true

class DeleteModeratorService
  attr_reader :moderator

  def initialize(moderator)
    @moderator = moderator
  end

  def call
    moderator.destroy!
  end
end
