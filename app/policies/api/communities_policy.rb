class Api::CommunitiesPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user?
  end

  def update?
    moderator?
  end

  def permitted_attributes_for_create
    [:url, :title, :description]
  end

  def permitted_attributes_for_update
    [:title, :description]
  end
end
