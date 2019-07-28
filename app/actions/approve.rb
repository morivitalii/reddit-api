# frozen_string_literal: true

class Approve
  def initialize(model, current_user)
    @model = model
    @current_user = current_user
  end

  def call
    ActiveRecord::Base.transaction do
      @model.approve!

      CreateLog.new(
        sub: @model.sub,
        current_user: @current_user,
        action: :mark_thing_as_approved,
        attributes: [:approved_at, :deleted_at, :deletion_reason, :text],
        loggable: @model,
        model: @model
      ).call
    end
  end
end
