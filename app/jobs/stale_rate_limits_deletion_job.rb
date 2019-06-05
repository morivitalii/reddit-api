# frozen_string_literal: true

class StaleRateLimitsDeletionJob < ApplicationJob
  queue_as :high_priority

  def perform
    StaleRateLimitsDeletion.new.call
  end
end
