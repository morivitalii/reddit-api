# frozen_string_literal: true

class CreateRuleForm
  include ActiveModel::Model

  attr_accessor :sub, :title, :description
  attr_reader :rule

  def save
    @rule = Rule.create!(
      sub: sub,
      title: title,
      description: description
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
