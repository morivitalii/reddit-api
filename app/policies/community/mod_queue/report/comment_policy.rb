# frozen_string_literal: true

class Community::ModQueue::Report::CommentPolicy < ApplicationPolicy
  def index?
    moderator?
  end
end
