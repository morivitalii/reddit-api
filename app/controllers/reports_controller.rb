# frozen_string_literal: true

class ReportsController < ApplicationController
  layout "narrow"

  before_action :set_sub, only: [:index, :comments]
  before_action :set_reportable, only: [:show, :new, :create]
  before_action -> { authorize(Report) }

  def index
    scope = policy_scope(Report)

    @records, @pagination_record = scope.type("Post").includes(reportable: [:sub, :user]).paginate(after: params[:after])

    @records = @records.map(&:reportable).map(&:decorate)
  end

  def comments
    scope = policy_scope(Report)

    @records, @pagination_record = scope.type("Comment").includes(reportable: [:user, :post]).paginate(after: params[:after])

    @records = @records.map(&:reportable).map(&:decorate)
  end

  def show
    @reports = @reportable.reports.includes(:user).order(id: :asc).limit(25).all

    render partial: "show"
  end

  def new
    @form = CreateReport.new
    @reasons = @reportable.sub.rules.all
    @other_reasons = DeletionReason.global.all

    render partial: "new"
  end

  def create
    @form = CreateReport.new(create_params)

    if @form.save
      render json: t("thanks_for_report")
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def pundit_user
    UserContext.new(current_user, @sub || @reportable&.sub)
  end

  def set_sub
    @sub = Sub.find_by_lower_url(params[:sub])
  end

  def set_reportable
    if params[:post_id].present?
      @reportable = Post.find(params[:post_id])
    elsif params[:comment_id].present?
      @reportable = Comment.find(params[:comment_id])
    end
  end

  def create_params
    params.require(:create_report).permit(:text).merge(model: @reportable, current_user: current_user)
  end
end
