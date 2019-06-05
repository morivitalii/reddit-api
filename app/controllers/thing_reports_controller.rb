# frozen_string_literal: true

class ThingReportsController < BaseThingController
  def index
    ThingReportsPolicy.authorize!(:index, @sub)

    @reports = @thing.reports.includes(:user).order(id: :asc).all

    render partial: "index"
  end

  def new
    ThingReportsPolicy.authorize!(:create)

    @form = CreateThingReport.new

    render partial: "new"
  end

  def create
    ThingReportsPolicy.authorize!(:create)

    @form = CreateThingReport.new(create_params.merge(thing: @thing, current_user: Current.user))
    @form.save!

    head :no_content
  end

  private

  def create_params
    params.require(:create_thing_report).permit(:text)
  end
end
