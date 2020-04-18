class Api::Communities::ModQueues::Reports::CommentsController < ApplicationController
  before_action :set_community
  before_action -> { authorize(Api::Communities::ModQueues::Reports::CommentsPolicy) }

  def index
    query = CommentsQuery.new(@community.comments).reported.includes(:created_by, :post, :community)
    comments = paginate(
      query,
      attributes: [:id],
      order: :desc,
      limit: 25,
      after: params[:after].present? ? Comment.where(id: params[:after]).take : nil
    )

    render json: CommentSerializer.serialize(comments)
  end

  private

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
