# frozen_string_literal: true

class CreateGlobalDeletionReason
  include ActiveModel::Model

  attr_accessor :current_user, :title, :description
  attr_reader :deletion_reason

  def save
    @deletion_reason = DeletionReason.create!(
      title: @title,
      description: @description
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  else
    CreateLogJob.perform_later(
      current_user: @current_user,
      action: "create_global_deletion_reason",
      model: @deletion_reason
    )
  end
end
