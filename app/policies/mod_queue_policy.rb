# frozen_string_literal: true

class ModQueuePolicy < ApplicationPolicy
  def posts?
    moderator?
  end

  alias comments? posts?
end