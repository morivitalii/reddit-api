# frozen_string_literal: true

class BatchDeleteRateLimits
  def initialize(ids:)
    @ids = ids
  end

  def call
    RateLimit.where(id: @ids).delete_all
  end
end
