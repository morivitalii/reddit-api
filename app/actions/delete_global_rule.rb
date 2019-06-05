# frozen_string_literal: true

class DeleteGlobalRule
  def initialize(rule:, current_user:)
    @rule = rule
    @current_user = current_user
  end

  def call
    @rule.destroy!

    CreateLogJob.perform_later(
      current_user: @current_user,
      action: "delete_global_rule",
      model: @rule
    )
  end
end
