# frozen_string_literal: true

class ModeratorsController < ApplicationController
  before_action :set_moderator, only: [:destroy]
  before_action :set_sub
  before_action :set_facade
  before_action -> { authorize(Moderator) }, only: [:index, :new, :create]
  before_action -> { authorize(@moderator) }, only: [:destroy]

  def index
    @records, @pagination = scope.paginate(after: params[:after])
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
    DeleteModeratorService.new(@moderator).call

    head :no_content
  end

  private

  def context
    Context.new(current_user, @sub)
  end

  def scope
    query_class = ModeratorsQuery

    if @sub.present?
      scope = query_class.new.sub(@sub)
    else
      scope = query_class.new.global
    end

    scope = query_class.new(scope).filter_by_username(params[:query])
    scope.includes(:user, :invited_by)
  end

  def set_facade
    @facade = ModeratorsFacade.new(context)
  end

  def set_sub
    if @moderator.present?
      @sub = @moderator.sub
    elsif params[:sub].present?
      @sub = SubsQuery.new.where_url(params[:sub]).take!
    end
  end

  def set_moderator
    @moderator = Moderator.find(params[:id])
  end

  def create_params
    attributes = policy(Moderator).permitted_attributes_for_create

    params.require(:create_moderator).permit(attributes).merge(sub: @sub, current_user: current_user)
  end
end
