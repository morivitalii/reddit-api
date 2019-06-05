# frozen_string_literal: true

class UpdateSubDeletionReason
  include ActiveModel::Model

  attr_accessor :deletion_reason, :current_user, :title, :description

  def save!
    @deletion_reason.update!(
      title: @title,
      description: @description
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    raise ActiveModel::ValidationError.new(self)
  else
    CreateLogJob.perform_later(
      sub: @deletion_reason.sub,
      current_user: @current_user,
      action: "update_sub_deletion_reason",
      model: @deletion_reason
    )
  end
end
