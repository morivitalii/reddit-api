class CommunitiesPolicy < ApplicationPolicy
  def show?
    true
  end

  def update?
    moderator?
  end

  alias edit? update?

  def permitted_attributes_for_update
    [:title, :description]
  end
end
