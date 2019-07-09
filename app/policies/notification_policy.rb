# frozen_string_literal: true

class NotificationPolicy < ApplicationPolicy
  def index?
    user?
  end
end
