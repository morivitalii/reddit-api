# frozen_string_literal: true

class MarkThingAsApproved
  def initialize(thing:, current_user:)
    @thing = thing
    @current_user = current_user
  end

  def call
    return false if @thing.approved?

    ActiveRecord::Base.transaction do
      @thing.update!(
        approved: true,
        approved_by: @current_user,
        approved_at: Time.current
      )

      CreateLog.new(
        sub: @thing.sub,
        current_user: @current_user,
        action: :mark_thing_as_approved,
        attributes: [:approved, :deleted, :deletion_reason, :text],
        loggable: @thing,
        model: @thing
      ).call
    end
  end
end
