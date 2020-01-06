class Api::Communities::Posts::Top::AllController < ApplicationController
  before_action :set_community
  before_action -> { authorize(Api::Communities::Posts::Top::AllPolicy) }

  def index
    query = PostsQuery.new(@community.posts).not_removed
    query = query.includes(:community, :created_by, :edited_by, :approved_by, :removed_by)
    posts = query.paginate(
      attributes: [:top_score, :id],
      order: :desc,
      limit: 25,
      after: params[:after]
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
