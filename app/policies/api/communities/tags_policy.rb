class Api::Communities::TagsPolicy < ApplicationPolicy
  def index?
    !exiled? && !banned?
  end

  def show?
    !exiled? && !banned?
  end

  def create?
    admin? || (!exiled? && moderator?)
  end

  def update?
    admin? || (!exiled? && moderator?)
  end

  def destroy?
    admin? || (!exiled? && moderator?)
  end

  def permitted_attributes
    [:text]
  end
end
