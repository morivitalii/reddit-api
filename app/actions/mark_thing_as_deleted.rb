# frozen_string_literal: true

class MarkThingAsDeleted
  include ActiveModel::Model

  attr_accessor :thing, :current_user, :deletion_reason

  def save
    ActiveRecord::Base.transaction do
      @thing.update!(
        deleted: true,
        deleted_by: @current_user,
        deleted_at: Time.current,
        deletion_reason: @deletion_reason
      )

      CreateLog.new(
        sub: @thing.sub,
        current_user: @current_user,
        action: :mark_thing_as_deleted,
        attributes: [:deleted, :deletion_reason, :approved_at, :text],
        loggable: @thing,
        model: @thing
      ).call
    end
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
