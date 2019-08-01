# frozen_string_literal: true

class PostsQuery
  attr_reader :relation

  def initialize(relation = Post.all)
    @relation = relation
  end

  def not_moderated
    relation.where(deleted_at: nil, approved_at: nil)
  end

  def from_sub(sub = nil)
    return relation if sub.blank?

    relation.where(sub: sub)
  end

  def from_subs_where_user_is_moderator(user)
    relation.joins(sub: :moderators).where(subs: { moderators: { user: user } })
  end
end