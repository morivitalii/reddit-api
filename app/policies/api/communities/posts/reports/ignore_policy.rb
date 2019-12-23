class Api::Communities::Posts::Reports::IgnorePolicy < ApplicationPolicy
  def create?
    moderator?
  end

  alias destroy? create?
end
