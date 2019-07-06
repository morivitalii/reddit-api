# frozen_string_literal: true

class IgnoreThingReportsController < BaseThingController
  def create
    IgnoreThingReportsPolicy.authorize!(:create, @thing)

    IgnoreThingReports.new(thing: @thing, current_user: current_user).call

    head :no_content
  end

  def destroy
    IgnoreThingReportsPolicy.authorize!(:destroy, @thing)

    DoNotIgnoreThingReports.new(thing: @thing, current_user: current_user).call

    head :no_content
  end
end