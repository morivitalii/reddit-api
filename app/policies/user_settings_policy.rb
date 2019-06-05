# frozen_string_literal: true

class UserSettingsPolicy < ApplicationPolicy
  def update?
    user?
  end
end
