# frozen_string_literal: true

class UpdateDeletionReason
  include ActiveModel::Model

  attr_accessor :deletion_reason, :current_user, :title, :description

  def save
    ActiveRecord::Base.transaction do
      @deletion_reason.update!(
        title: @title,
        description: @description
      )

      CreateLog.new(
        sub: @deletion_reason.sub,
        current_user: @current_user,
        action: :update_deletion_reason,
        attributes: [:title, :description],
        model: @deletion_reason
      ).call
    end
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
