# frozen_string_literal: true

class ThingsActions < ApplicationPolicy
  def index?
    user?
  end
end
