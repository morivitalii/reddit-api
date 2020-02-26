class Api::Communities::ModQueues::Reports::PostsController < ApplicationController
  before_action :set_community
  before_action -> { authorize(Api::Communities::ModQueues::Reports::PostsPolicy) }

  def index
    query = PostsQuery.new(@community.posts).reported.includes(:community, :user)
    posts = paginate(
      query,
      attributes: [:id],
      order: :desc,
      limit: 25,
      after: params[:after]
    )
  end

  private

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
