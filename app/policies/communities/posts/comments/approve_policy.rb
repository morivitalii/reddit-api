class Communities::Posts::Comments::ApprovePolicy < ApplicationPolicy
  def update?
    moderator?
  end
end