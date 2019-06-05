# frozen_string_literal: true

class ThingApproveController < BaseThingController
  def create
    ThingApprovePolicy.authorize!(:create, @thing)

    MarkThingAsApproved.new(thing: @thing, current_user: Current.user).call

    head :no_content
  end
end
