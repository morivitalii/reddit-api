# frozen_string_literal: true

class DeleteSubRule
  def initialize(rule:, current_user:)
    @rule = rule
    @current_user = current_user
  end

  def call
    @rule.destroy!

    CreateLogJob.perform_later(
      sub: @rule.sub,
      current_user: @current_user,
      action: "delete_sub_rule",
      model: @rule
    )
  end
end
