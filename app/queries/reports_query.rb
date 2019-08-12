# frozen_string_literal: true

class ReportsQuery < ApplicationQuery
  def search_by_sub(sub)
    return relation if sub.blank?

    relation.where(sub: sub)
  end

  def in_subs_moderated_by_user(user)
    relation.joins(sub: :moderators).where(subs: { moderators: { user: user } })
  end

  def posts_reports
    relation.where(reportable_type: "Post")
  end

  def comments_reports
    relation.where(reportable_type: "Comment")
  end

  def recent(limit)
    relation.order(id: :desc).limit(limit)
  end
end