# frozen_string_literal: true

class ModeratorsController < ApplicationController
  before_action :set_community
  before_action :set_facade
  before_action :set_moderator, only: [:destroy]
  before_action -> { authorize(Moderator) }, only: [:index, :new, :create]
  before_action -> { authorize(@moderator) }, only: [:destroy]

  def index
    @records, @pagination = query.paginate(after: params[:after])
  end

  def new
    @form = CreateModeratorForm.new

    render partial: "new"
  end

  def create
    @form = CreateModeratorForm.new(create_params)

    if @form.save
      head :no_content, location: community_moderators_path(@community)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def destroy
    DeleteModeratorService.new(@moderator).call

    head :no_content
  end

  private

  def context
    Context.new(current_user, @community)
  end

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end

  def set_facade
    @facade = ModeratorsFacade.new(context)
  end

  def set_moderator
    @moderator = @community.moderators.find(params[:id])
  end

  def query
    ModeratorsQuery.new(@community.moderators).search_by_username(params[:query]).includes(:user)
  end

  def create_params
    attributes = policy(Moderator).permitted_attributes_for_create

    params.require(:create_moderator_form).permit(attributes).merge(community: @community)
  end
end
