# frozen_string_literal: true

class ThingsActionsPolicy < ApplicationPolicy
  def index?
    user?
  end
end
