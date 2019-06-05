# frozen_string_literal: true

class StaleBansDeletionJob < ApplicationJob
  queue_as :high_priority

  def perform
    StaleBansDeletion.new.call
  end
end
