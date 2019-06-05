# frozen_string_literal: true

class RateLimit < ApplicationRecord
  POST = 50
  COMMENT = 150

  belongs_to :user

  def stale?
    created_at < 1.day.ago
  end

  def reset
    update!(hits: 1, created_at: Time.current)
  end

  def self.beyond?(key, sub)
    return false if Current.user.staff? || Current.user.moderator?(sub) || Current.user.contributor?(sub)

    rate_limit = Current.user.rate_limits.where(key: key).take
    return false if rate_limit.blank? || rate_limit.stale?

    rate_limit.hits >= RateLimit.const_get(key.upcase)
  end

  def self.hit(key, sub)
    return if Current.user.staff? || Current.user.moderator?(sub) || Current.user.contributor?(sub)

    rate_limit = Current.user.rate_limits.find_or_create_by!(key: key)
    rate_limit.stale? ? rate_limit.reset : rate_limit.increment!(:hits)
  end
end
