# frozen_string_literal: true

class NotModeratedPostsQuery
  attr_reader :relation

  def initialize(relation = Post.all)
    @relation = relation
  end

  def call
    relation.where(deleted_at: nil, approved_at: nil)
  end

  def not_deleted
    relation.where(deleted_at: nil)
  end

  def not_approved
    relation.where(approved_at: nil)
  end

  def with_sub(sub)
    relation.where(sub: sub)
  end

  def personalized(user)
    relation.joins(sub: :moderators).where(subs: { moderators: { user: user } })
  end
end