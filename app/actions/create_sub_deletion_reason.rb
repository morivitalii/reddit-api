# frozen_string_literal: true

class CreateSubDeletionReason
  include ActiveModel::Model

  attr_accessor :sub, :current_user, :title, :description
  attr_reader :deletion_reason

  def save
    @deletion_reason = @sub.deletion_reasons.create!(
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
      action: "create_sub_deletion_reason",
      model: @deletion_reason
    )
  end
end
