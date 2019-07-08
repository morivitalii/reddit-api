# frozen_string_literal: true

class ApproveThingsController < ApplicationController
  before_action :set_thing
  before_action -> { authorize(@thing, policy_class: ApproveThingPolicy) }

  def create
    MarkThingAsApproved.new(thing: @thing, current_user: current_user).call

    head :no_content
  end

  private

  def set_thing
    @thing = Thing.find(params[:thing_id])
  end
end
