# frozen_string_literal: true

class SubFollowController < BaseSubController
  before_action -> { authorize(Follow) }

  def create
    CreateSubFollow.new(sub: @sub, current_user: current_user).call

    head :no_content
  end

  def destroy
    DeleteSubFollow.new(sub: @sub, current_user: current_user).call

    head :no_content
  end
end
