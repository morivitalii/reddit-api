# frozen_string_literal: true

class CreateDeletionReason
  include ActiveModel::Model

  attr_accessor :current_user, :sub, :title, :description
  attr_reader :deletion_reason

  def save
    @deletion_reason = DeletionReason.create!(
      sub: @sub,
      title: @title,
      description: @description
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  else
    CreateLogJob.perform_later(
      sub: @sub,
      current_user: @current_user,
      action: "create_deletion_reason",
      model: @deletion_reason
    )
  end
end
