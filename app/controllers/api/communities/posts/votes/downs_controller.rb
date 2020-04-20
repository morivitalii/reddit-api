class Api::Communities::Posts::Votes::DownsController < ApplicationController
  before_action :set_community
  before_action :set_post
  before_action -> { authorize(Api::Communities::Posts::Votes::DownsPolicy, @post) }

  def create
    vote = Communities::Posts::CreateDownVote.new(post: @post, user: current_user).call

    # TODO remove two following lines after transition to frontend framework
    @post.reload
    @post.vote = vote

    render json: {score: post.score, up_vote_link: post.up_vote_link, down_vote_link: post.down_vote_link}
  end

  def destroy
    Communities::Posts::DeleteDownVote.new(post: @post, user: current_user).call

    # TODO remove following line after transition to frontend framework
    @post.reload

    render json: {score: post.score, up_vote_link: post.up_vote_link, down_vote_link: post.down_vote_link}
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
