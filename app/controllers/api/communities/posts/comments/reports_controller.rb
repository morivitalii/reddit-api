class Api::Communities::Posts::Comments::ReportsController < ApplicationController
  before_action :set_community
  before_action :set_post
  before_action :set_comment
  before_action -> { authorize(Api::Communities::Posts::Comments::ReportsPolicy, @comment) }

  def index
    query = @comment.reports.includes(:user, :community, reportable: [post: :community])
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
    service = Communities::Posts::Comments::CreateReport.new(create_params)

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

  def set_comment
    @comment = @post.comments.find(params[:comment_id])
  end

  def create_params
    attributes = Api::Communities::Posts::Comments::ReportsPolicy.new(pundit_user, @comment).permitted_attributes_for_create
    params.permit(attributes).merge(comment: @comment, user: current_user)
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
