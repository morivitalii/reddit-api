# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_reportable
  before_action -> { authorize(Report) }

  def index
    @reports = reportable_query.all

    render partial: "index"
  end

  def new
    @form = CreateReportForm.new
    @reasons = @reportable.community.rules.all

    render partial: "new"
  end

  def create
    @form = CreateReportForm.new(create_params)

    if @form.save
      render json: t("thanks_for_report")
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def pundit_user
    Context.new(current_user, @reportable.community)
  end

  def set_reportable
    if params[:post_id].present?
      @reportable = Post.find(params[:post_id])
    elsif params[:comment_id].present?
      @reportable = Comment.find(params[:comment_id])
    end
  end

  def reportable_query
    ReportsQuery.new(@reportable.reports).recent(25).includes(:user)
  end

  def create_params
    attributes = policy(Report).permitted_attributes_for_create

    params.require(:create_report_form).permit(attributes).merge(reportable: @reportable, user: current_user)
  end
end
