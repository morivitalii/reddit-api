class Communities::Posts::Comments::RemovePolicy < ApplicationPolicy
  def edit?
    author? || moderator?
  end

  alias update? edit?

  def update_reason?
    moderator?
  end

  def permitted_attributes_for_update
    attributes = []
    attributes.push(:reason) if update_reason?
    attributes
  end

  private

  def author?
    user? && user.id == record.user_id
  end
end