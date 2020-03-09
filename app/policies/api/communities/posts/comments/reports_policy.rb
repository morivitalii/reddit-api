class Api::Communities::Posts::Comments::ReportsPolicy < ApplicationPolicy
  def index?
    moderator? && !banned?
  end

  def create?
    user? && !muted? && !banned?
  end

  alias new? create?

  def permitted_attributes_for_create
    [:text]
  end
end
