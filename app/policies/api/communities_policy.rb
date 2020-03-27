class Api::CommunitiesPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    !banned?
  end

  def create?
    user?
  end

  def update?
    user? && (admin? || moderator?)
  end

  def permitted_attributes_for_create
    [:url, :title, :description]
  end

  def permitted_attributes_for_update
    [:title, :description]
  end
end
