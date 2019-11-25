class Communities::Posts::ExplicitPolicy < ApplicationPolicy
  def create?
    moderator?
  end

  alias destroy? create?
end
