class Api::Communities::Posts::RemovePolicy < ApplicationPolicy
  def update?
    admin? || (!exiled? && ((author? && !muted?) || moderator?))
  end

  def update_reason?
    admin? || (!exiled? && moderator?)
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
