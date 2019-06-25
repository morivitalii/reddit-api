# frozen_string_literal: true

class ReportThingsController < BaseThingController
  def index
    ReportThingPolicy.authorize!(:index, @sub)

    @reports = @thing.reports.includes(:user).order(id: :asc).all

    render partial: "index"
  end

  def new
    ReportThingPolicy.authorize!(:create)

    @form = CreateThingReport.new

    render partial: "new"
  end

  def create
    ReportThingPolicy.authorize!(:create)

    @form = CreateThingReport.new(create_params.merge(thing: @thing, current_user: Current.user))

    if @form.save
      head :no_content
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:create_thing_report).permit(:text)
  end
end
