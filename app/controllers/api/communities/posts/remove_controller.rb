class Api::Communities::Posts::RemoveController < ApplicationController
  before_action :set_community
  before_action :set_post
  before_action -> { authorize(Api::Communities::Posts::RemovePolicy, @post) }

  def update
    service = Communities::RemovePost.new(update_params)

    if service.call
      render json: PostSerializer.serialize(service.post)
    else
      render json: service.errors, status: :unprocessable_entity
    end
  end

  private

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end

  def set_post
    @post = @community.posts.find(params[:post_id])
  end

  def update_params
    attributes = Api::Communities::Posts::RemovePolicy.new(pundit_user, @post).permitted_attributes_for_update
    params.permit(attributes).merge(post: @post, user: current_user)
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
