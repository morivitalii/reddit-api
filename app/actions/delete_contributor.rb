# frozen_string_literal: true

class DeleteContributor
  def initialize(contributor:, current_user:)
    @contributor = contributor
    @current_user = current_user
  end

  def call
    @contributor.destroy!
  end
end
