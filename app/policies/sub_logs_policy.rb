# frozen_string_literal: true

class SubLogsPolicy < ApplicationPolicy
  def index?(sub)
    staff? || sub_moderator?(sub)
  end
end
