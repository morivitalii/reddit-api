# frozen_string_literal: true

class CreateRule
  include ActiveModel::Model

  attr_accessor :current_user, :sub, :title, :description
  attr_reader :rule

  def save
    @rule = Rule.create!(
      sub: @sub,
      title: @title,
      description: @description
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  else
    CreateLogJob.perform_later(
      sub: @sub,
      current_user: @current_user,
      action: "create_rule",
      model: @rule
    )
  end
end
