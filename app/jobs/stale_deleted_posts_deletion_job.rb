# frozen_string_literal: true

class StaleDeletedPostsDeletionJob < ApplicationJob
  queue_as :high_priority

  def perform
    StaleDeletedPostsDeletion.new.call
  end
end
