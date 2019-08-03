# frozen_string_literal: true

class ReportsQuery
  attr_reader :relation

  def initialize(relation = Report.all)
    @relation = relation
  end

  def posts
    relation.where(reportable_type: "Post")
  end

  def comments
    relation.where(reportable_type: "Comment")
  end

  def filter_by_sub(sub)
    return relation if sub.blank?

    relation.where(sub: sub)
  end

  def subs_where_user_moderator(user)
    relation.joins(sub: :moderators).where(subs: { moderators: { user: user } })
  end

  def recent(limit)
    relation.order(id: :desc).limit(limit)
  end
end