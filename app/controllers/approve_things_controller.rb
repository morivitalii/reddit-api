# frozen_string_literal: true

class ApproveThingsController < BaseThingController
  before_action -> { authorize(@thing, policy_class: ApproveThingPolicy) }

  def create
    MarkThingAsApproved.new(thing: @thing, current_user: current_user).call

    head :no_content
  end
end
