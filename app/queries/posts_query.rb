# frozen_string_literal: true

class PostsQuery < ApplicationQuery
  def not_moderated
    relation.where(deleted_at: nil, approved_at: nil)
  end

  def search_by_sub(sub)
    return relation if sub.blank?

    relation.where(sub: sub)
  end

  def in_subs_moderated_by_user(user)
    relation.joins(sub: :moderators).where(subs: { moderators: { user: user } })
  end

  def created_after(datetime)
    relation.where("created_at > ?", datetime)
  end

  def search_created_after(datetime)
    return relation if datetime.blank?

    created_after(datetime)
  end
end