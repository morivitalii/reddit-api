class Api::Communities::Posts::Votes::DownsController < ApplicationController
  before_action :set_community
  before_action :set_post
  before_action -> { authorize(Api::Communities::Posts::Votes::DownsPolicy, @post) }

  def create
    Communities::Posts::CreateDownVote.new(post: @post, user: current_user).call

    render json: PostSerializer.serialize(@post)
  end

  def destroy
    Communities::Posts::DeleteDownVote.new(post: @post, user: current_user).call

    render json: PostSerializer.serialize(@post)
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
