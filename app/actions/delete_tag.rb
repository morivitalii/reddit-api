# frozen_string_literal: true

class DeleteTag
  def initialize(tag:, current_user:)
    @tag = tag
    @current_user = current_user
  end

  def call
    @tag.destroy!

    CreateLogJob.perform_later(
      sub: @tag.sub,
      current_user: @current_user,
      action: "delete_tag",
      model: @tag
    )
  end
end
