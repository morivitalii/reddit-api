# frozen_string_literal: true

class UsersController < ApplicationController
  layout "narrow", only: [:show]

  before_action -> { authorize(User) }
  before_action :set_user, only: [:show]
  before_action :set_current_user, only: [:edit, :update]
  before_action :set_navigation_title

  def show
    @records = Thing.thing_type(ThingsTypes.new(params[:thing_type]).key)
                   .not_deleted
                   .sort_records_by(ThingsSorting.new(params[:thing_sort]).key)
                   .records_after(params[:after].present? ? @user.things.find_by_id(params[:after]) : nil, ThingsSorting.new(params[:thing_sort]).key)
                   .records_after_date(ThingsDates.new(params[:thing_date]).date)
                   .where(user: @user)
                   .includes(:sub, :user, :post)
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end

  def edit
    @form = UpdateUser.new(email: @user.email)
  end

  def update
    @form = UpdateUser.new(update_params)

    if @form.save
      head :no_content, location: edit_users_path
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.where("lower(username) = ?", params[:id].downcase).take!
  end

  def set_current_user
    @user = current_user
  end

  def set_navigation_title
    @navigation_title = @user.username
  end

  def update_params
    params.require(:update_user).permit(:email, :password, :password_current).merge(user: @user)
  end
end
