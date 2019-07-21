# frozen_string_literal: true

class ReportsController < ApplicationController
  layout "narrow", only: [:index]

  before_action :set_sub, only: [:index]
  before_action :set_thing, only: [:thing_index, :new, :create]
  before_action -> { authorize(Report) }

  def index
    scope = policy_scope(Report)

    if @sub.present?
      scope = scope.where(things: { sub: @sub })
    end

    @records = scope.distinct
                   .merge(Thing.thing_type(type))
                   .reverse_chronologically(after)
                   .includes(thing: [:sub, :user, :post])
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end

    @records = @records.map(&:thing)
  end

  def thing_index
    @reports = @thing.reports.includes(:user).order(id: :asc).limit(25).all

    render partial: "show"
  end

  def new
    @form = CreateReport.new

    render partial: "new"
  end

  def create
    @form = CreateReport.new(create_params)

    if @form.save
      head :no_content
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def pundit_user
    UserContext.new(current_user, @thing&.sub || @sub)
  end

  def set_sub
    @sub = params[:sub].present? ? Sub.where("lower(url) = ?", params[:sub]).take! : nil
  end

  def set_thing
    @thing = Thing.find(params[:thing_id])
  end

  def type
    ThingsTypes.new(params[:type]).key
  end

  def after
    params[:after].present? ? Report.find_by_id(params[:after]) : nil
  end

  def create_params
    params.require(:create_report).permit(:text).merge(thing: @thing, current_user: current_user)
  end
end
