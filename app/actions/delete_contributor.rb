# frozen_string_literal: true

class DeleteContributor
  def initialize(contributor:, current_user:)
    @contributor = contributor
    @current_user = current_user
  end

  def call
    ActiveRecord::Base.transaction do
      @contributor.destroy!

      CreateLog.new(
        sub: @contributor.sub,
        current_user: @current_user,
        action: :delete_contributor,
        loggable: @contributor.user
      ).call
    end
  end
end
