# frozen_string_literal: true

class DeleteRule
  def initialize(rule:, current_user:)
    @rule = rule
    @current_user = current_user
  end

  def call
    ActiveRecord::Base.transaction do
      @rule.destroy!

      CreateLog.new(
        sub: @rule.sub,
        current_user: @current_user,
        action: :delete_rule,
        attributes: [:title, :description],
        model: @rule
      ).call
    end
  end
end
