# frozen_string_literal: true

class MarkThingAsNotExplicit
  def initialize(thing:, current_user:)
    @thing = thing
    @current_user = current_user
  end

  def call
    @thing.update!(explicit: false)

    CreateLogJob.perform_later(
      sub: @thing.sub,
      current_user: @current_user,
      action: "mark_thing_as_not_explicit",
      loggable: @thing,
      model: @thing
    )
  end
end
