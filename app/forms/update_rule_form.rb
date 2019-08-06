# frozen_string_literal: true

class UpdateRuleForm
  include ActiveModel::Model

  attr_accessor :rule, :title, :description

  def save
    rule.update!(
      title: title,
      description: description
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
