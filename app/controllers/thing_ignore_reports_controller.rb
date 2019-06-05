# frozen_string_literal: true

class ThingIgnoreReportsController < BaseThingController
  def create
    ThingIgnoreReportsPolicy.authorize!(:create, @thing)

    IgnoreThingReports.new(thing: @thing, current_user: Current.user).call

    head :no_content
  end

  def destroy
    ThingIgnoreReportsPolicy.authorize!(:destroy, @thing)

    DoNotIgnoreThingReports.new(thing: @thing, current_user: Current.user).call

    head :no_content
  end
end