# frozen_string_literal: true

class IgnoreThingReportsController < BaseThingController
  before_action -> { authorize(@thing, policy_class: IgnoreThingReportsPolicy) }

  def create
    IgnoreThingReports.new(thing: @thing, current_user: current_user).call

    head :no_content
  end

  def destroy
    DoNotIgnoreThingReports.new(thing: @thing, current_user: current_user).call

    head :no_content
  end
end