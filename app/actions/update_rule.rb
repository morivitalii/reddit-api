# frozen_string_literal: true

class UpdateRule
  include ActiveModel::Model

  attr_accessor :rule, :current_user, :title, :description

  def save
    ActiveRecord::Base.transaction do
      @rule.update!(
        title: @title,
        description: @description
      )

      CreateLog.new(
        sub: @rule.sub,
        current_user: @current_user,
        action: :update_rule,
        attributes: [:title, :description],
        model: @rule
      ).call
    end
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
