class Api::Communities::PostsPolicy < ApplicationPolicy
  def show?
    !exiled? && !banned?
  end

  def create?
    user? && !exiled? && !muted? && !banned?
  end

  def update?
    author? && !exiled? && !muted? && !banned?
  end

  def permitted_attributes_for_create
    [:title, :text, :explicit, :spoiler]
  end

  def permitted_attributes_for_update
    [:text]
  end

  private

  def author?
    user? && user.id == record.created_by_id
  end
end
