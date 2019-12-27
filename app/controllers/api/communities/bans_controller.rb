class Api::Communities::BansController < ApplicationController
  before_action :set_community
  before_action :set_ban, only: [:edit, :update, :destroy]
  before_action -> { authorize(nil, policy_class: Api::Communities::BansPolicy) }, only: [:index, :new, :create]
  before_action -> { authorize(@ban, policy_class: Api::Communities::BansPolicy) }, only: [:edit, :update, :destroy]
  decorates_assigned :bans, :ban, :community

  def index
    @bans, @pagination = query.paginate(after: params[:after])
  end

  def new
    @form = Communities::CreateBanForm.new

    render partial: "new"
  end

  def edit
    attributes = @ban.slice(:reason, :days, :permanent)

    @form = Communities::UpdateBanForm.new(attributes)

    render partial: "edit"
  end

  def create
    @form = Communities::CreateBanForm.new(create_params)

    if @form.save
      head :no_content, location: community_bans_path(@community)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    @form = Communities::UpdateBanForm.new(update_params)

    if @form.save
      render partial: "ban"
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def destroy
    Communities::DeleteBanService.new(@ban).call

    head :no_content
  end

  private

  def query
    BansQuery.new(@community.bans).search_by_username(search_param).includes(:user)
  end

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end

  def set_ban
    @ban = @community.bans.find(params[:id])
  end

  helper_method :search_param
  def search_param
    params.dig(:search_ban_form, :username)
  end

  def create_params
    attributes = Api::Communities::BansPolicy.new(pundit_user).permitted_attributes_for_create
    params.require(:communities_create_ban_form).permit(attributes).merge(community: @community)
  end

  def update_params
    attributes = Api::Communities::BansPolicy.new(pundit_user, @ban).permitted_attributes_for_update
    params.require(:communities_update_ban_form).permit(attributes).merge(ban: @ban)
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
