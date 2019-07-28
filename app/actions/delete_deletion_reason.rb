# frozen_string_literal: true

class DeleteDeletionReason
  def initialize(deletion_reason:, current_user:)
    @deletion_reason = deletion_reason
    @current_user = current_user
  end

  def call
    @deletion_reason.destroy!
  end
end
