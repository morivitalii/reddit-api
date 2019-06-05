# frozen_string_literal: true

class CreateLogJob < ApplicationJob
  queue_as :low_priority

  before_enqueue do
    model = arguments.first.delete(:model)
    loggable = arguments.first.delete(:loggable)
    current_user = arguments.first.delete(:current_user)
    sub = arguments.first.delete(:sub)

    arguments.first[:user_id] = current_user.id

    if model.present?
      arguments.first[:details] = Log.model_changes(model, arguments.first[:action].to_sym)
    end

    if loggable.present?
      arguments.first[:loggable_id] = loggable.id
      arguments.first[:loggable_type] = loggable.class.name
    end

    if sub.present?
      arguments.first[:sub_id] = sub.id
    end
  end

  def perform(params)
    CreateLog.new(params).call
  end
end
