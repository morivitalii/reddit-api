# frozen_string_literal: true

class DeleteDeletionReason
  def initialize(deletion_reason:, current_user:)
    @deletion_reason = deletion_reason
    @current_user = current_user
  end

  def call
    ActiveRecord::Base.transaction do
      @deletion_reason.destroy!

      CreateLog.new(
        sub: @deletion_reason.sub,
        current_user: @current_user,
        action: :delete_deletion_reason,
        attributes: [:title, :description],
        model: @deletion_reason
      ).call
    end
  end
end
