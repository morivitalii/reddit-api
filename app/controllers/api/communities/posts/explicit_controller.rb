class Api::Communities::Posts::ExplicitController < ApplicationController
  before_action :set_community
  before_action :set_post
  before_action -> { authorize(@post, policy_class: Api::Communities::Posts::ExplicitPolicy) }
  decorates_assigned :post

  def create
    Communities::Posts::MarkAsExplicitService.new(@post).call

    render json: {explicit: post.explicit, explicit_link: post.explicit_link}
  end

  def destroy
    Communities::Posts::MarkAsNotExplicitService.new(@post).call

    render json: {explicit: post.explicit, explicit_link: post.explicit_link}
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
