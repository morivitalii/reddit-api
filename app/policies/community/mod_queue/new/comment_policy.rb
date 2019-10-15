# frozen_string_literal: true

class Community::ModQueue::New::CommentPolicy < ApplicationPolicy
  def index?
    moderator?
  end
end
