class Api::Communities::ModQueues::New::PostsController < ApplicationController
  before_action :set_community
  before_action -> { authorize(Api::Communities::ModQueues::New::PostsPolicy) }

  def index
    query = PostsQuery.new(@community.posts).not_moderated.includes(:created_by, :community)
    posts = paginate(
      query,
      attributes: [:id],
      order: :desc,
      limit: 25,
      after: params[:after].present? ? Post.where(id: params[:after]).take : nil
    )

    render json: PostSerializer.serialize(posts)
  end

  private

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
