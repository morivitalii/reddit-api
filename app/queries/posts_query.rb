# frozen_string_literal: true

class PostsQuery
  attr_reader :relation

  def initialize(relation = Post.all)
    @relation = relation
  end

  def not_moderated
    relation.where(deleted_at: nil, approved_at: nil)
  end

  def filter_by_sub(sub)
    return relation if sub.blank?

    relation.where(sub: sub)
  end

  def filter_by_date(date)
    return relation if date.blank?

    relation.where("created_at > ?", date)
  end

  def subs_where_user_is_moderator(user)
    relation.joins(sub: :moderators).where(subs: { moderators: { user: user } })
  end
end