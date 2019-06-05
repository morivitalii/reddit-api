# frozen_string_literal: true

class SubModQueuePolicy < ApplicationPolicy
  def index?(sub)
    staff? || moderator?(sub)
  end
end
