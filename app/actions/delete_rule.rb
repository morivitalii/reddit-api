# frozen_string_literal: true

class DeleteRule
  def initialize(rule:, current_user:)
    @rule = rule
    @current_user = current_user
  end

  def call
    @rule.destroy!
  end
end
