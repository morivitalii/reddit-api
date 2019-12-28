class Api::Communities::ModQueues::Reports::PostsController < ApplicationController
  before_action :set_community
  before_action -> { authorize(Api::Communities::ModQueues::Reports::PostsPolicy) }

  def index
    @posts, @pagination = query.paginate(after: params[:after])
  end

  private

  def query
    PostsQuery.new(@community.posts).reported.includes(:community, :user)
  end

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
