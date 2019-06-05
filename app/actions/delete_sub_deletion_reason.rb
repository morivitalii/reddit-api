# frozen_string_literal: true

class DeleteSubDeletionReason
  def initialize(deletion_reason:, current_user:)
    @deletion_reason = deletion_reason
    @current_user = current_user
  end

  def call
    @deletion_reason.destroy!

    CreateLogJob.perform_later(
      sub: @deletion_reason.sub,
      current_user: @current_user,
      action: "delete_sub_deletion_reason",
      model: @deletion_reason
    )
  end
end
