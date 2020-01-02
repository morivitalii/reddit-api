class Api::Communities::FollowController < ApiApplicationController
  before_action :set_community
  before_action -> { authorize(Api::Communities::FollowsPolicy) }

  def create
    Communities::CreateFollowService.new(@community, current_user).call

    render json: {follow: true, followers_count: community.followers_count}
  end

  def destroy
    Communities::DeleteFollowService.new(@community, current_user).call

    render json: {follow: false, followers_count: community.followers_count}
  end

  private

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
