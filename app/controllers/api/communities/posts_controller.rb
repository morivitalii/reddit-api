class Api::Communities::PostsController < ApplicationController
  before_action :set_community
  before_action :set_post, only: [:show, :update]
  before_action -> { authorize(Api::Communities::PostsPolicy) }, only: [:create]
  before_action -> { authorize(Api::Communities::PostsPolicy, @post) }, only: [:show, :update]

  def show
    render json: PostSerializer.serialize(@post)
  end

  def create
    service = Communities::CreatePost.new(create_params)

    rate_limit_action = :create_post
    rate_limit = 100

    if validate_rate_limit(service, attribute: :title, action: rate_limit_action, limit: rate_limit) && service.call
      hit_rate_limit(rate_limit_action)

      render json: PostSerializer.serialize(service.post)
    else
      render json: service.errors, status: :unprocessable_entity
    end
  end

  def update
    service = Communities::UpdatePost.new(update_params)

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
    @post = @community.posts.includes(:community, :created_by, :edited_by, :approved_by, :removed_by).find(params[:id])
  end

  def create_params
    attributes = Api::Communities::PostsPolicy.new(pundit_user).permitted_attributes_for_create

    params.permit(attributes).merge(community: @community, created_by: current_user)
  end

  def update_params
    attributes = Api::Communities::PostsPolicy.new(pundit_user, @post).permitted_attributes_for_update

    params.permit(attributes).merge(post: @post, edited_by: current_user)
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
