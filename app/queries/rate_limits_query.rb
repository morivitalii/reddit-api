# frozen_string_literal: true

class RateLimitsQuery < ApplicationQuery
  def daily
    relation.where("rate_limits.created_at > ?", 1.day.ago)
  end

  def stale
    relation.where("rate_limits.created_at < ?", 1.day.ago)
  end
end