# frozen_string_literal: true

class DeleteFileJob < ApplicationJob
  queue_as :low_priority
  retry_on StandardError, wait: 10.seconds, attempts: 2

  def perform(data)
    Shrine::Attacher.delete(data)
  end
end
