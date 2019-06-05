# frozen_string_literal: true

class DeleteSubContributor
  def initialize(contributor:, current_user:)
    @contributor = contributor
    @current_user = current_user
  end

  def call
    @contributor.destroy!

    CreateLogJob.perform_later(
      sub: @contributor.sub,
      current_user: @current_user,
      action: "delete_sub_contributor",
      loggable: @contributor.user
    )
  end
end
