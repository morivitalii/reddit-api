class Api::Communities::ModeratorsController < ApplicationController
  before_action :set_community
  before_action :set_moderator, only: [:destroy]
  before_action -> { authorize(nil, policy_class: Api::Communities::ModeratorsPolicy) }, only: [:index, :new, :create]
  before_action -> { authorize(@moderator, policy_class: Api::Communities::ModeratorsPolicy) }, only: [:destroy]
  decorates_assigned :moderators, :community

  def index
    @moderators, @pagination = query.paginate(after: params[:after])
  end

  def new
    @form = Communities::CreateModeratorForm.new

    render partial: "new"
  end

  def create
    @form = Communities::CreateModeratorForm.new(create_params)

    if @form.save
      head :no_content, location: community_moderators_path(@community)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def destroy
    Communities::DeleteModeratorService.new(@moderator).call

    head :no_content
  end

  private

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end

  def set_moderator
    @moderator = @community.moderators.find(params[:id])
  end

  def query
    ModeratorsQuery.new(@community.moderators).search_by_username(search_param).includes(:user)
  end

  helper_method :search_param
  def search_param
    params.dig(:search_moderator_form, :username)
  end

  def create_params
    attributes = Api::Communities::ModeratorsPolicy.new(pundit_user).permitted_attributes_for_create
    params.require(:communities_create_moderator_form).permit(attributes).merge(community: @community)
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
