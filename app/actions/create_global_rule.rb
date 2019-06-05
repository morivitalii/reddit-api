# frozen_string_literal: true

class CreateGlobalRule
  include ActiveModel::Model

  attr_accessor :current_user, :title, :description
  attr_reader :rule

  def save!
    @rule = Rule.create!(
      title: @title,
      description: @description
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    raise ActiveModel::ValidationError.new(self)
  else
    CreateLogJob.perform_later(
      current_user: @current_user,
      action: "create_global_rule",
      model: @rule
    )
  end
end
