class Communities::RulesPolicy < ApplicationPolicy
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

  def permitted_attributes
    [:title, :description]
  end
end
