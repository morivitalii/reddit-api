# frozen_string_literal: true

class NotificationPolicy < ApplicationPolicy
  def index?
    user_signed_in?
  end
end
