# frozen_string_literal: true

class DeleteDeletionReasonService
  attr_reader :deletion_reason

  def initialize(deletion_reason)
    @deletion_reason = deletion_reason
  end

  def call
    deletion_reason.destroy!
  end
end
