# frozen_string_literal: true

class SubLogsPolicy < ApplicationPolicy
  def index?(sub)
    staff? || moderator?(sub)
  end
end
