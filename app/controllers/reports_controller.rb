# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_sub
  before_action :set_facade
  before_action :set_reportable, only: [:show, :new, :create]
  before_action -> { authorize(Report) }

  def posts
    @records, @pagination = posts_query.paginate(after: params[:after])
    @records.map!(&:decorate)
  end

  def comments
    @records, @pagination = comments_query.paginate(after: params[:after])
    @records.map!(&:decorate)
  end

  def show
    @reports = reportable_query.all

    render partial: "show"
  end

  def new
    @form = CreateReportForm.new
    @reasons = @reportable.sub.rules.all

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

  def set_sub
    @sub = SubsQuery.new.with_url(params[:sub_id]).take!
  end

  def set_facade
    @facade = ReportsFacade.new(context)
  end

  def set_reportable
    if params[:post_id].present?
      @reportable = Post.find(params[:post_id])
    elsif params[:comment_id].present?
      @reportable = Comment.find(params[:comment_id])
    end
  end

  def posts_query
    PostsQuery.new(@sub.posts).reported.includes(:sub, :user)
  end

  def comments_query
    CommentsQuery.new(@sub.comments).reported.includes(:user, :post, :sub)
  end

  def reportable_query
    ReportsQuery.new(@reportable.reports).recent(25).includes(:user)
  end

  def create_params
    attributes = policy(Report).permitted_attributes_for_create

    params.require(:create_report_form).permit(attributes).merge(reportable: @reportable, user: current_user)
  end
end
