# frozen_string_literal: true

class BansController < ApplicationController
  before_action :set_ban, only: [:edit, :update, :destroy]
  before_action :set_sub
  before_action :set_facade, only: [:index]
  before_action -> { authorize(Ban) }, only: [:index, :new, :create]
  before_action -> { authorize(@ban) }, only: [:edit, :update, :destroy]

  def index
    @records, @pagination = scope.paginate(after: params[:after])
  end

  def new
    @form = CreateBan.new

    render partial: "new"
  end

  def edit
    attributes = @ban.slice(:reason, :days, :permanent)

    @form = UpdateBan.new(attributes)

    render partial: "edit"
  end

  def create
    @form = CreateBan.new(create_params)

    if @form.save
      head :no_content, location: bans_path(sub: @sub)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    @form = UpdateBan.new(update_params)

    if @form.save
      render partial: "ban", object: @form.ban
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def destroy
    DeleteBan.new(ban: @ban, current_user: current_user).call

    head :no_content
  end

  private

  def context
    Context.new(current_user, @sub)
  end

  def scope
    query_class = BansQuery

    if @sub.present?
      scope = query_class.new.sub(@sub)
    else
      scope = query_class.new.global
    end

    scope = query_class.new(scope).filter_by_username(params[:query])
    scope.includes(:user, :banned_by)
  end

  def set_sub
    if @ban.present?
      @sub = @ban.sub
    elsif params[:sub].present?
      @sub = SubsQuery.new.where_url(params[:sub]).take!
    end
  end

  def set_ban
    @ban = Ban.find(params[:id])
  end

  def set_facade
    @facade = BansFacade.new(context)
  end

  def create_params
    attributes = policy(Ban).permitted_attributes_for_create

    params.require(:create_ban).permit(attributes).merge(sub: @sub, current_user: current_user)
  end

  def update_params
    attributes = policy(@ban).permitted_attributes_for_update

    params.require(:update_ban).permit(attributes).merge(ban: @ban, current_user: current_user)
  end
end
