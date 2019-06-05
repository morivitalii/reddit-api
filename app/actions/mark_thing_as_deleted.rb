# frozen_string_literal: true

class MarkThingAsDeleted
  include ActiveModel::Model

  attr_accessor :thing, :current_user, :deletion_reason

  def save!
    @thing.update!(
      deleted: true,
      deleted_by: @current_user,
      deleted_at: Time.current,
      deletion_reason: @deletion_reason
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    raise ActiveModel::ValidationError.new(self)
  else
    CreateLogJob.perform_later(
      sub: @thing.sub,
      current_user: @current_user,
      action: "mark_thing_as_deleted",
      loggable: @thing,
      model: @thing
    )
  end
end
