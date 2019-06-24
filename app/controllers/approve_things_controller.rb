# frozen_string_literal: true

class ApproveThingsController < BaseThingController
  def create
    ApproveThingPolicy.authorize!(:create, @thing)

    MarkThingAsApproved.new(thing: @thing, current_user: Current.user).call

    head :no_content
  end
end
