# frozen_string_literal: true

class StoreFileJob < ApplicationJob
  queue_as :high_priority
  retry_on StandardError, wait: 1.second, attempts: 2

  def perform(data)
    Shrine::Attacher.promote(data)
  end
end
