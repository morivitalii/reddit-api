# frozen_string_literal: true

class CreateSubRule
  include ActiveModel::Model

  attr_accessor :sub, :current_user, :title, :description
  attr_reader :rule

  def save!
    @rule = @sub.rules.create!(
      title: @title,
      description: @description
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    raise ActiveModel::ValidationError.new(self)
  else
    CreateLogJob.perform_later(
      sub: @sub,
      current_user: @current_user,
      action: "create_sub_rule",
      model: @rule
    )
  end
end
