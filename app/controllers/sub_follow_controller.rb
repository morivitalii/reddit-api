# frozen_string_literal: true

class SubFollowController < BaseSubController
  def create
    SubFollowsPolicy.authorize!(:create)

    CreateSubFollow.new(sub: @sub, current_user: Current.user).call

    head :no_content
  end

  def destroy
    SubFollowsPolicy.authorize!(:destroy)

    DeleteSubFollow.new(sub: @sub, current_user: Current.user).call

    head :no_content
  end
end
