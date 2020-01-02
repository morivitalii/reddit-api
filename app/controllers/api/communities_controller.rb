class Api::CommunitiesController < ApiApplicationController
  before_action :set_community, only: [:show, :update]
  before_action -> { authorize(Api::CommunitiesPolicy) }

  def show
    render json: CommunitySerializer.serialize(@community)
  end

  def create
    service = CreateCommunity.new(create_params)

    if service.call
      render json: CommunitySerializer.serialize(service.community)
    else
      render json: service.errors, status: :unprocessable_entity
    end
  end

  def update
    service = UpdateCommunity.new(update_params)

    if service.call
      render json: CommunitySerializer.serialize(service.community)
    else
      render json: service.errors, status: :unprocessable_entity
    end
  end

  private

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:id]).take!
  end

  def create_params
    attributes = Api::CommunitiesPolicy.new(pundit_user).permitted_attributes_for_create

    params.permit(attributes).merge(user: current_user)
  end

  def update_params
    attributes = Api::CommunitiesPolicy.new(pundit_user, @community).permitted_attributes_for_update

    params.permit(attributes).merge(community: @community)
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
