# frozen_string_literal: true

class SubModQueuePolicy < ApplicationPolicy
  def index?
    staff? || sub_moderator?(record)
  end
end
