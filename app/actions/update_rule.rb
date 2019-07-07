# frozen_string_literal: true

class UpdateRule
  include ActiveModel::Model

  attr_accessor :rule, :current_user, :title, :description

  def save
    @rule.update!(
      title: @title,
      description: @description
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  else
    CreateLogJob.perform_later(
      sub: @rule.sub,
      current_user: @current_user,
      action: "update_rule",
      model: @rule
    )
  end
end
