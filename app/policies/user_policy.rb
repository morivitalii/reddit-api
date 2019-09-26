# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def posts_index?
    true
  end

  alias comments_index? posts_index?

  def update?
    user?
  end

  alias edit? update?

  def permitted_attributes_for_update
    [:email, :password, :password_current]
  end
end
