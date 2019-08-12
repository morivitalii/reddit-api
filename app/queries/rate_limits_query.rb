# frozen_string_literal: true

class RateLimitsQuery < ApplicationQuery
  def daily
    relation.where("created_at > ?", 1.day.ago)
  end

  def stale
    relation.where("created_at < ?", 1.day.ago)
  end
end