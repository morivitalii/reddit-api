# frozen_string_literal: true

class UpdateDeletionReason
  include ActiveModel::Model

  attr_accessor :deletion_reason, :current_user, :title, :description

  def save
    @deletion_reason.update!(
      title: @title,
      description: @description
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
