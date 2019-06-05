# frozen_string_literal: true

class IgnoreThingReports
  def initialize(thing:, current_user:)
    @thing = thing
    @current_user = current_user
  end

  def call
    @thing.update!(ignore_reports: true)

    CreateLogJob.perform_later(
      sub: @thing.sub,
      current_user: @current_user,
      action: "ignore_thing_reports",
      loggable: @thing,
      model: @thing
    )
  end
end