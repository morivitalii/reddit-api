class Api::Communities::PostsController < ApiApplicationController
  before_action :set_community
  before_action :set_post, only: [:show, :update]
  before_action -> { authorize(Api::Communities::PostsPolicy) }, only: [:index, :create]
  before_action -> { authorize(Api::Communities::PostsPolicy, @post) }, only: [:show, :update]

  def index
    query = PostsQuery.new(@community.posts).not_removed
    query = PostsQuery.new(query).search_created_after(date_value)
    query = query.includes(:community, :created_by, :edited_by, :approved_by, :removed_by)
    posts = query.paginate(attributes: [sort_attribute, :id], after: params[:after])

    render json: PostSerializer.serialize(posts)
  end

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

  def sort_attribute
    sort_options = %w[hot new top controversy]
    sort_value = sort_options.include?(params[:sort]) ? params[:sort] : "hot"

    "#{sort_value}_score"
  end

  def date_value
    date_options = %w[day week month]
    date_value = date_options.include?(params[:date]) ? params[:date] : nil

    # Time.now.advance does not accept string keys. wat?
    date_value.present? ? Time.now.advance("#{date_value}s".to_sym => -1) : nil
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
