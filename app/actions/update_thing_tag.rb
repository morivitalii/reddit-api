# frozen_string_literal: true

class UpdateThingTag
  include ActiveModel::Model

  attr_accessor :thing, :current_user, :tag

  def save!
    @thing.update!(tag: @tag)
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    raise ActiveModel::ValidationError.new(self)
  else
    CreateLogJob.perform_later(
      sub: @thing.sub,
      current_user: @current_user,
      action: "update_thing_tag",
      loggable: @thing,
      model: @thing
    )
  end
end
