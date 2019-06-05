# frozen_string_literal: true

class BatchDeleteRateLimitsJob < ApplicationJob
  queue_as :low_priority

  def perform(ids)
    BatchDeleteRateLimits.new(ids: ids).call
  end
end
