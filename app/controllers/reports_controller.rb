# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_reportable, only: [:show, :new, :create]
  before_action :set_sub
  before_action :set_facade
  before_action -> { authorize(Report) }

  def index
    @records, @pagination = posts_scope.paginate(after: params[:after])
    @records.map!(&:reportable).map!(&:decorate)
  end

  def comments
    @records, @pagination = comments_scope.paginate(after: params[:after])
    @records.map!(&:reportable).map!(&:decorate)
  end

  def show
    @reports = reportable_scope.all

    render partial: "show"
  end

  def new
    @form = CreateReportForm.new
    @reasons = @reportable.sub.rules.all
    @other_reasons = DeletionReasonsQuery.new.global.all

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

  def context
    Context.new(current_user, @sub)
  end

  def posts_scope
    query_class = ReportsQuery
    scope = query_class.new.filter_by_sub(@sub)
    scope = query_class.new(scope).posts
    scope = policy_scope(scope)
    scope.includes(reportable: [:sub, :user])
  end

  def comments_scope
    query_class = ReportsQuery
    scope = query_class.new.filter_by_sub(@sub)
    scope = query_class.new(scope).comments
    scope = policy_scope(scope)
    scope.includes(reportable: [:user, post: :sub])
  end

  def reportable_scope
    recent = ReportsQuery.new(@reportable.reports).recent(25)
    recent.includes(:user)
  end

  def set_facade
    @facade = ReportsFacade.new(context)
  end

  def set_sub
    if @reportable.present?
      @sub = @reportable.sub
    elsif params[:sub].present?
      @sub = SubsQuery.new.where_url(params[:sub]).take!
    end
  end

  def set_reportable
    if params[:post_id].present?
      @reportable = Post.find(params[:post_id])
    elsif params[:comment_id].present?
      @reportable = Comment.find(params[:comment_id])
    end
  end

  def create_params
    attributes = policy(Report).permitted_attributes_for_create

    params.require(:create_report_form).permit(attributes).merge(reportable: @reportable, user: current_user)
  end
end
