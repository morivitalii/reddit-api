class Api::Communities::Posts::ReportsController < ApplicationController
  before_action :set_community
  before_action :set_post
  before_action -> { authorize(Api::Communities::Posts::ReportsPolicy, @post) }

  def index
    query = @post.reports.includes(:user, :community, reportable: [:community])
    reports = paginate(
      query,
      attributes: [:id],
      order: :desc,
      limit: 25,
      after: params[:after].present? ? Report.where(id: params[:after]).take : nil
    )

    render json: ReportSerializer.serialize(reports)
  end

  def create
    service = Communities::Posts::CreateReport.new(create_params)

    if service.call
      render json: ReportSerializer.serialize(service.report)
    else
      render json: service.errors, status: :unprocessable_entity
    end
  end

  private

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end

  def set_post
    @post = @community.posts.find(params[:post_id])
  end

  def create_params
    attributes = Api::Communities::Posts::ReportsPolicy.new(pundit_user, @post).permitted_attributes_for_create
    params.permit(attributes).merge(post: @post, user: current_user)
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
