# frozen_string_literal: true

class RateLimitsQuery
  attr_reader :relation

  def initialize(relation = RateLimit.all)
    @relation = relation
  end

  def user_daily(user)
    relation.where(user: user).where(created_at: 1.day.ago..Time.now)
  end

  def stale
    relation.where("created_at < ?", 1.day.ago)
  end
end