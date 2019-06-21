# frozen_string_literal: true

class LogsPolicy < ApplicationPolicy
  def index?
    staff?
  end
end
