# frozen_string_literal: true

class SubPolicy < ApplicationPolicy
  def show?
    true
  end

  def update?
    user_signed_in? && context.user.id == record.user_id
  end

  alias edit? update?
end
