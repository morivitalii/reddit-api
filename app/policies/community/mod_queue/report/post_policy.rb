# frozen_string_literal: true

class Community::ModQueue::Report::PostPolicy < ApplicationPolicy
  def index?
    moderator?
  end
end
