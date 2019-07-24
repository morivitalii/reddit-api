# frozen_string_literal: true

class MarkThingAsApproved
  def initialize(thing:, current_user:)
    @thing = thing
    @current_user = current_user
  end

  def call
    ActiveRecord::Base.transaction do
      @thing.update!(
        approved_by: @current_user,
        approved_at: Time.current
      )

      CreateLog.new(
        sub: @thing.sub,
        current_user: @current_user,
        action: :mark_thing_as_approved,
        attributes: [:approved_at, :deleted_at, :deletion_reason, :text],
        loggable: @thing,
        model: @thing
      ).call
    end
  end
end
