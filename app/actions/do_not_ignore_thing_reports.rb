# frozen_string_literal: true

class DoNotIgnoreThingReports
  def initialize(thing:, current_user:)
    @thing = thing
    @current_user = current_user
  end

  def call
    @thing.update!(ignore_reports: false)

    CreateLogJob.perform_later(
      sub: @thing.sub,
      current_user: @current_user,
      action: "do_not_ignore_thing_reports",
      loggable: @thing,
      model: @thing
    )
  end
end