# frozen_string_literal: true

class ModQueuePolicy < ApplicationPolicy
  def new_posts?
    moderator?
  end

  alias new_comments? new_posts?

  def reported_posts?
    moderator?
  end

  alias reported_comments? reported_posts?
end