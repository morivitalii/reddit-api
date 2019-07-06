# frozen_string_literal: true

class SubModQueuePolicy < ApplicationPolicy
  def index?(sub)
    staff? || sub_moderator?(sub)
  end
end
