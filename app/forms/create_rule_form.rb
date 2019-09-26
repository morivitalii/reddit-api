# frozen_string_literal: true

class CreateRuleForm
  include ActiveModel::Model

  attr_accessor :community, :title, :description
  attr_reader :rule

  def save
    @rule = Rule.create!(
      community: community,
      title: title,
      description: description
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end

  def persisted?
    false
  end
end
