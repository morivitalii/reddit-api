# frozen_string_literal: true

class ModQueuePolicy < ApplicationPolicy
  def new_posts_index?
    moderator?
  end

  alias new_comments_index? new_posts_index?

  def reported_posts_index?
    moderator?
  end

  alias reported_comments_index? reported_posts_index?
end
