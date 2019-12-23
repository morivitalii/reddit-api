class Api::Communities::Posts::SpoilerPolicy < ApplicationPolicy
  def create?
    moderator?
  end

  alias destroy? create?
end
