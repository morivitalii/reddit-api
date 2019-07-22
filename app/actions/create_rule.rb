# frozen_string_literal: true

class CreateRule
  include ActiveModel::Model

  attr_accessor :current_user, :sub, :title, :description
  attr_reader :rule

  def save
    ActiveRecord::Base.transaction do
      @rule = Rule.create!(
        sub: @sub,
        title: @title,
        description: @description
      )

      CreateLog.new(
        sub: @sub,
        current_user: @current_user,
        action: :create_rule,
        attributes: [:title, :description],
        model: @rule
      ).call
    end
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
