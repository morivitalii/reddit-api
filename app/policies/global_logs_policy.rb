# frozen_string_literal: true

class GlobalLogsPolicy < ApplicationPolicy
  def index?
    staff?
  end
end
