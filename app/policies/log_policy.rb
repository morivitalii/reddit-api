# frozen_string_literal: true

class LogPolicy < ApplicationPolicy
  def index?
    staff?
  end
end
