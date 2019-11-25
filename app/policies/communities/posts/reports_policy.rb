class Communities::Posts::ReportsPolicy < ApplicationPolicy
  def index?
    moderator?
  end

  def create?
    user?
  end

  alias new? create?

  def permitted_attributes_for_create
    [:text]
  end
end
