# frozen_string_literal: true

class MarkThingAsSpoiler
  def initialize(thing:, current_user:)
    @thing = thing
    @current_user = current_user
  end

  def call
    @thing.update!(spoiler: true)

    CreateLogJob.perform_later(
      sub: @thing.sub,
      current_user: @current_user,
      action: "mark_thing_as_spoiler",
      loggable: @thing,
      model: @thing
    )
  end
end
