# frozen_string_literal: true

class CreateDeletionReasonForm
  include ActiveModel::Model

  attr_accessor :sub, :title, :description
  attr_reader :deletion_reason

  def save
    @deletion_reason = DeletionReason.create!(
      sub: sub,
      title: title,
      description: description
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
