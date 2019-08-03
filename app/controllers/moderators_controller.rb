# frozen_string_literal: true

class ModeratorsController < ApplicationController
  before_action :set_moderator, only: [:destroy]
  before_action :set_sub
  before_action -> { authorize(Moderator) }, only: [:index, :new, :create]
  before_action -> { authorize(@moderator) }, only: [:destroy]

  def index
    @records, @pagination_record = scope.paginate(after: params[:after])
  end

  def new
    @form = CreateModerator.new

    render partial: "new"
  end

  def create
    @form = CreateModerator.new(create_params)

    if @form.save
      head :no_content, location: moderators_path(sub: @sub)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def destroy
    DeleteModerator.new(moderator: @moderator, current_user: current_user).call

    head :no_content
  end

  private

  def scope
    query_class = ModeratorsQuery

    if @sub.present?
      scope = query_class.new.where_sub(@sub)
    else
      scope = query_class.new.where_global
    end

    scope = query_class.new(scope).filter_by_username(params[:query])
    scope.includes(:user, :invited_by)
  end

  def pundit_user
    UserContext.new(current_user, @sub)
  end

  def set_sub
    @sub = @moderator.present? ? @moderator.sub : Sub.find_by_lower_url(params[:sub])
  end

  def set_moderator
    @moderator = Moderator.find(params[:id])
  end

  def create_params
    attributes = policy(Moderator).permitted_attributes_for_create

    params.require(:create_moderator).permit(attributes).merge(sub: @sub, current_user: current_user)
  end
end
