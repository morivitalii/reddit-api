class Api::Communities::FollowsController < ApplicationController
  before_action :set_community
  before_action -> { authorize(Api::Communities::FollowsPolicy) }

  def index
    query = @community.follows.includes(:user, :followable)
    follows = paginate(
      query,
      attributes: [:id],
      order: :desc,
      limit: 25,
      after: params[:after].present? ? Follow.where(id: params[:after]).take : nil
    )

    render json: FollowSerializer.new(follows)
  end

  def create
    follow = Communities::CreateFollow.new(community: @community, user: current_user).call

    render json: FollowSerializer.serialize(follow)
  end

  def destroy
    Communities::DeleteFollow.new(community: @community, user: current_user).call

    head :no_content
  end

  private

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
