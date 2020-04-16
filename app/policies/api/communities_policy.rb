class Api::CommunitiesPolicy < ApplicationPolicy
  def index?
    !exiled?
  end

  def show?
    !exiled? && !banned?
  end

  def create?
    user? && !exiled?
  end

  def update?
    admin? || (!exiled? && moderator?)
  end

  def permitted_attributes_for_create
    [:url, :title, :description]
  end

  def permitted_attributes_for_update
    [:title, :description]
  end
end
