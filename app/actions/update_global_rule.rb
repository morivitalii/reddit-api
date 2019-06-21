# frozen_string_literal: true

class UpdateGlobalRule
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
      current_user: @current_user,
      action: "update_global_rule",
      model: @rule
    )
  end
end
