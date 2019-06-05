# frozen_string_literal: true

class MarkThingAsNotSpoiler
  def initialize(thing:, current_user:)
    @thing = thing
    @current_user = current_user
  end

  def call
    @thing.update!(spoiler: false)

    CreateLogJob.perform_later(
      sub: @thing.sub,
      current_user: @current_user,
      action: "mark_thing_as_not_spoiler",
      loggable: @thing,
      model: @thing
    )
  end
end
