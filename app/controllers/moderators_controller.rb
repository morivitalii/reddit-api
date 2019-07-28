# frozen_string_literal: true

class ModeratorsController < ApplicationController
  before_action :set_sub, only: [:index, :search, :new, :create]
  before_action :set_moderator, only: [:destroy]
  before_action -> { authorize(Moderator) }

  def index
    @records, @pagination_record = Moderator.where(sub: @sub).includes(:user, :invited_by).paginate(after: params[:after])
  end

  def search
    @records = Moderator.where(sub: @sub).search(params[:query]).all

    render "index"
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

  def pundit_user
    UserContext.new(current_user, @sub || @moderator&.sub)
  end

  def set_sub
    @sub = params[:sub].present? ? Sub.where("lower(url) = ?", params[:sub].downcase).take! : nil
  end

  def set_moderator
    @moderator = Moderator.find(params[:id])
  end

  def create_params
    params.require(:create_moderator).permit(:username).merge(sub: @sub, current_user: current_user)
  end
end
