class Api::Communities::ModQueues::New::CommentsController < ApplicationController
  before_action :set_community
  before_action -> { authorize(Api::Communities::ModQueues::New::CommentsPolicy) }

  def index
    query = CommentsQuery.new(@community.comments).not_moderated.includes(:created_by, :community, post: [:created_by, :community])
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
