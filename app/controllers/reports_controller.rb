# frozen_string_literal: true

class ReportsController < ApplicationController
  layout "narrow"

  before_action :set_reportable, only: [:show, :new, :create]
  before_action :set_sub
  before_action -> { authorize(Report) }

  def index
    scope = policy_scope(posts_scope)
    @records, @pagination_record = scope.paginate(after: params[:after])
    @records.map!(&:reportable).map!(&:decorate)
  end

  def comments
    scope = policy_scope(comments_scope)
    @records, @pagination_record = scope.paginate(after: params[:after])
    @records.map!(&:reportable).map!(&:decorate)
  end

  def show
    @reports = reportable_scope.all

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
    UserContext.new(current_user, @sub)
  end

  def set_sub
    @sub = @reportable.present? ? @reportable.sub : Sub.find_by_lower_url(params[:sub])
  end

  def set_reportable
    if params[:post_id].present?
      @reportable = Post.find(params[:post_id])
    elsif params[:comment_id].present?
      @reportable = Comment.find(params[:comment_id])
    end
  end

  def posts_scope
    query_class = ReportsQuery

    scope = query_class.new.posts
    scope = query_class.new(scope).where_sub(@sub)
    scope.includes(reportable: [:sub, :user])
  end

  def comments_scope
    query_class = ReportsQuery

    scope = query_class.new.comments
    scope = query_class.new(scope).where_sub(@sub)
    scope.includes(reportable: [:user, post: :sub])
  end

  def reportable_scope
    recent = ReportsQuery.new(@reportable.reports).recent(25)

    recent.includes(:user)
  end

  def create_params
    attributes = policy(Report).permitted_attributes_for_create

    params.require(:create_report).permit(attributes).merge(model: @reportable, current_user: current_user)
  end
end
