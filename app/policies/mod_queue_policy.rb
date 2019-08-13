# frozen_string_literal: true

class ModQueuePolicy < ApplicationPolicy
  def posts?
    user_signed_in? && user_moderator?
  end

  alias comments? posts?
end