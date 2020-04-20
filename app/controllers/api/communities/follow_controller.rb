class Api::Communities::FollowController < ApplicationController
  before_action :set_community
  before_action -> { authorize(Api::Communities::FollowsPolicy) }

  def create
    follow = Communities::CreateFollow.new(community: @community, user: current_user).call

    render json: FollowSerializer.serialize(follow)
  end

  def destroy
    Communities::DeleteFollow.new(@community, current_user).call

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
