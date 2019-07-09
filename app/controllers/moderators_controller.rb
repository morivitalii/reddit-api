# frozen_string_literal: true

class ModeratorsController < ApplicationController
  before_action :set_sub, only: [:index, :search, :new, :create]
  before_action :set_moderator, only: [:edit, :update, :confirm, :destroy]
  before_action -> { authorize(@sub, policy_class: ModeratorPolicy) }, only: [:index, :search, :new, :create]
  before_action -> { authorize(@moderator.sub, policy_class: ModeratorPolicy) }, only: [:edit, :update, :confirm, :destroy]

  def index
    @records = Moderator.include(ChronologicalOrder)
                   .where(sub: @sub)
                   .sort_records_chronologically
                   .records_after(params[:after].present? ? Moderator.find_by_id(params[:after]) : nil)
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

  def edit
    @form = UpdateModerator.new(master: @moderator.master)

    render partial: "edit"
  end

  def create
    @form = CreateModerator.new(create_params)

    if @form.save
      head :no_content, location: moderators_path(sub: @sub)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    @form = UpdateModerator.new(update_params)

    if @form.save
      render partial: "moderator", object: @form.moderator
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def confirm
    render partial: "confirm"
  end

  def destroy
    DeleteModerator.new(moderator: @moderator, current_user: current_user).call

    head :no_content
  end

  private

  def set_sub
    @sub = params[:sub].present? ? Sub.where("lower(url) = ?", params[:sub].downcase).take! : nil
  end

  def set_moderator
    @moderator = Moderator.find(params[:id])
  end

  def create_params
    params.require(:create_moderator).permit(:username, :master).merge(sub: @sub, current_user: current_user)
  end

  def update_params
    params.require(:update_moderator).permit(:master).merge(moderator: @moderator, current_user: current_user)
  end
end
