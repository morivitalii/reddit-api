class Api::Communities::Posts::Comments::Reports::IgnorePolicy < ApplicationPolicy
  def create?
    moderator?
  end

  alias destroy? create?
end
