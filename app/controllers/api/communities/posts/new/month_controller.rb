class Api::Communities::Posts::New::MonthController < ApplicationController
  before_action :set_community
  before_action -> { authorize(Api::Communities::Posts::New::MonthPolicy) }

  def index
    query = PostsQuery.new(@community.posts).not_removed
    query = PostsQuery.new(query).for_the_last_month
    query = query.includes(:community, :created_by, :edited_by, :approved_by, :removed_by)
    posts = paginate(
      query,
      attributes: [:new_score, :id],
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
