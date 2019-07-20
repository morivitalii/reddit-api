# frozen_string_literal: true

class UpdateThing
  include ActiveModel::Model

  attr_accessor :thing, :current_user, :tag, :explicit, :spoiler, :ignore_reports, :receive_notifications

  def save
    validate!

    attributes = {
      tag: @tag,
      explicit: @explicit,
      spoiler: @spoiler,
      ignore_reports: @ignore_reports,
      receive_notifications: @receive_notifications,
    }.compact

    @thing.update!(attributes)

    CreateLogJob.perform_later(
      sub: @thing.sub,
      current_user: @current_user,
      action: "update_thing",
      loggable: @thing,
      model: @thing
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end
end