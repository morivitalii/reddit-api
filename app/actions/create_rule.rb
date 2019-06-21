# frozen_string_literal: true

class CreateRule
  include ActiveModel::Model

  attr_accessor :current_user, :title, :description
  attr_reader :rule

  def save
    @rule = Rule.create!(
      title: @title,
      description: @description
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  else
    CreateLogJob.perform_later(
      current_user: @current_user,
      action: "create_global_rule",
      model: @rule
    )
  end
end
