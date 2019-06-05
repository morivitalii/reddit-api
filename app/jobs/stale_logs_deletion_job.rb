# frozen_string_literal: true

class StaleLogsDeletionJob < ApplicationJob
  queue_as :high_priority

  def perform
    StaleLogsDeletion.new.call
  end
end
