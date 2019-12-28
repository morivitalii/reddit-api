class Api::Communities::Posts::SpoilerController < ApplicationController
  before_action :set_community
  before_action :set_post
  before_action -> { authorize(@post, policy_class: Api::Communities::Posts::SpoilerPolicy) }

  def create
    Communities::Posts::MarkAsSpoilerService.new(@post).call

    render json: {spoiler: post.spoiler, spoiler_link: post.spoiler_link}
  end

  def destroy
    Communities::Posts::MarkAsNotSpoilerService.new(@post).call

    render json: {spoiler: post.spoiler, spoiler_link: post.spoiler_link}
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
