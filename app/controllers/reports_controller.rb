# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_community
  before_action :set_reportable, only: [:show, :new, :create]
  before_action :set_facade
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

  def context
    Context.new(current_user, @community)
  end

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end

  def set_reportable
    if params[:post_id].present?
      @reportable = Post.find(params[:post_id])
    elsif params[:comment_id].present?
      @reportable = Comment.find(params[:comment_id])
    end
  end

  def posts_query
    PostsQuery.new(@community.posts).reported.includes(:community, :user)
  end

  def comments_query
    CommentsQuery.new(@community.comments).reported.includes(:user, :post, :community)
  end

  def reportable_query
    ReportsQuery.new(@reportable.reports).recent(25).includes(:user)
  end

  def create_params
    attributes = policy(Report).permitted_attributes_for_create

    params.require(:create_report_form).permit(attributes).merge(reportable: @reportable, user: current_user)
  end
end
