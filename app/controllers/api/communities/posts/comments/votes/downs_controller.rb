class Api::Communities::Posts::Comments::Votes::DownsController < ApplicationController
  before_action :set_community
  before_action :set_post
  before_action :set_comment
  before_action -> { authorize(Api::Communities::Posts::Comments::Votes::DownsPolicy, @comment) }

  def create
    Communities::Posts::Comments::CreateDownVote.new(comment: @comment, user: current_user).call

    head :no_content
  end

  def destroy
    Communities::Posts::Comments::DeleteDownVote.new(comment: @comment, user: current_user).call

    head :no_content
  end

  private

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end

  def set_post
    @post = @community.posts.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:comment_id])
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
