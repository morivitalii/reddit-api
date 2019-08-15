# frozen_string_literal: true

class RulePolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    moderator?
  end

  alias new? create?

  def update?
    moderator?
  end

  alias edit? update?

  def destroy?
    moderator?
  end

  def permitted_attributes_for_create
    [:title, :description]
  end

  def permitted_attributes_for_update
    [:title, :description]
  end
end
