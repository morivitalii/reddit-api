class Api::Communities::Posts::ApproveController < ApplicationController
  before_action :set_community
  before_action :set_post
  before_action -> { authorize(@post, policy_class: Api::Communities::Posts::ApprovePolicy) }

  def update
    Communities::Posts::ApproveService.new(@post, current_user).call

    render json: {approve_link: post.approve_link, remove_link: post.remove_link}
  end

  private

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end

  def set_post
    @post = @community.posts.find(params[:post_id])
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
