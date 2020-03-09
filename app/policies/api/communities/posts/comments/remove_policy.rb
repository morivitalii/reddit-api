class Api::Communities::Posts::Comments::RemovePolicy < ApplicationPolicy
  def edit?
    author? && !muted? || moderator? && !banned?
  end

  alias update? edit?

  def update_reason?
    moderator? && !banned?
  end

  def permitted_attributes_for_update
    attributes = []
    attributes.push(:reason) if update_reason?
    attributes
  end

  private

  def author?
    user? && user.id == record.created_by_id
  end
end
