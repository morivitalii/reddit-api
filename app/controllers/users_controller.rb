# frozen_string_literal: true

class UsersController < ApplicationController
  layout "narrow", only: [:show]

  before_action -> { authorize(User) }
  before_action :set_user, only: [:show]
  before_action :set_current_user, only: [:edit, :update]

  def show
    @records, @pagination_record = Thing.not_deleted
                   .thing_type(type)
                   .in_date_range(date)
                   .where(user: @user)
                   .includes(:sub, :user, :post)
                   .paginate(attributes: ["#{sort}_score", :id], after: params[:after])
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

  def update_params
    params.require(:update_user).permit(:email, :password, :password_current).merge(user: @user)
  end

  def type
    ThingsTypes.new(params[:type]).key
  end

  def sort
    ThingsSorting.new(params[:sort]).key
  end

  def date
    ThingsDates.new(params[:date]).date
  end
end
