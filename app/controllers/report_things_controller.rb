# frozen_string_literal: true

class ReportThingsController < ApplicationController
  before_action :set_thing
  before_action -> { authorize(@thing, policy_class: ReportThingPolicy) }

  def index
    @reports = @thing.reports.includes(:user).order(id: :asc).all

    render partial: "index"
  end

  def new
    @form = CreateThingReport.new

    render partial: "new"
  end

  def create
    @form = CreateThingReport.new(create_params)

    if @form.save
      head :no_content
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def set_thing
    @thing = Thing.find(params[:id])
  end

  def create_params
    params.require(:create_thing_report).permit(:text).merge(thing: @thing, current_user: current_user)
  end
end
