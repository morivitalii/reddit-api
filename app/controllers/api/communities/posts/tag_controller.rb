class Api::Communities::Posts::TagController < ApplicationController
  before_action :set_community
  before_action :set_post
  before_action -> { authorize(Api::Communities::Posts::TagPolicy, @post) }

  def update
    Communities::UpdatePostTag.new(update_params).call

    render json: PostSerializer.serialize(@post)
  end

  private

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end

  def set_post
    @post = @community.posts.find(params[:post_id])
  end

  def update_params
    attributes = Api::Communities::Posts::TagPolicy.new(pundit_user, @post).permitted_attributes_for_update
    params.permit(attributes).merge(post: @post)
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
