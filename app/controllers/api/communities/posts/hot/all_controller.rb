class Api::Communities::Posts::Hot::AllController < ApplicationController
  before_action :set_community
  before_action -> { authorize(Api::Communities::Posts::Hot::AllPolicy) }

  def index
    query = PostsQuery.new(@community.posts).not_removed
    query = query.includes(:community, :created_by, :edited_by, :approved_by)
    posts = paginate(
      query,
      attributes: [:hot_score, :id],
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
