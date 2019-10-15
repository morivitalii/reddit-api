# frozen_string_literal: true

class Community::ModQueue::New::PostPolicy < ApplicationPolicy
  def index?
    moderator?
  end
end
