# frozen_string_literal: true

class UpdateDeletionReasonForm
  include ActiveModel::Model

  attr_accessor :deletion_reason, :title, :description

  def save
    deletion_reason.update!(
      title: title,
      description: description
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
