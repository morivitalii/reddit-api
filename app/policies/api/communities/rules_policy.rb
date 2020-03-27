class Api::Communities::RulesPolicy < ApplicationPolicy
  def index?
    !banned?
  end

  def create?
    user? && (admin? || moderator?)
  end

  def update?
    user? && (admin? || moderator?)
  end

  def destroy?
    user? && (admin? || moderator?)
  end

  def permitted_attributes
    [:title, :description]
  end
end
