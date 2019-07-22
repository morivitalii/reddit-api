# frozen_string_literal: true

class ModeratorsController < ApplicationController
  before_action :set_sub, only: [:index, :search, :new, :create]
  before_action :set_moderator, only: [:destroy]
  before_action -> { authorize(Moderator) }

  def index
    @records = Moderator.where(sub: @sub)
                   .chronologically(params[:after].present? ? Moderator.find_by_id(params[:after]) : nil)
                   .includes(:user, :invited_by)
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end
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
