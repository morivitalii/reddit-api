# frozen_string_literal: true

class UpdateSubRule
  include ActiveModel::Model

  attr_accessor :rule, :current_user, :title, :description

  def save!
    @rule.update!(
      title: @title,
      description: @description
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    raise ActiveModel::ValidationError.new(self)
  else
    CreateLogJob.perform_later(
      sub: @rule.sub,
      current_user: @current_user,
      action: "update_sub_rule",
      model: @rule
    )
  end
end
