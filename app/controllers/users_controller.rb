# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user
  before_action :set_facade
  before_action -> { authorize(@user) }

  def show
    @records, @pagination = Post.in_date_range(date)
                                       .where(user: @user)
                                       .includes(:sub, :user)
                                       .paginate(attributes: ["#{sort}_score", :id], after: params[:after])

    @records = @records.map(&:decorate)
  end

  def comments
    @records, @pagination = Comment.in_date_range(date)
                                       .where(user: @user)
                                       .includes(:user, :post)
                                       .paginate(attributes: ["#{sort}_score", :id], after: params[:after])

    @records = @records.map(&:decorate)

    render "show"
  end

  def edit
    attributes = @user.slice(:email)

    @form = UpdateUserForm.new(attributes)
  end

  def update
    @form = UpdateUserForm.new(update_params)

    if @form.save
      head :no_content, location: edit_users_path
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    if params[:id].present?
      @user = UsersQuery.new.where_username(params[:id]).take!
    else
      @user = current_user
    end
  end

  def set_facade
    @facade = UsersFacade.new(context, @user)
  end

  def update_params
    attributes = policy(@user).permitted_attributes_for_update

    params.require(:update_user_form).permit(attributes).merge(user: @user)
  end

  def sort
    ThingsSorting.new(params[:sort]).key
  end

  def date
    ThingsDates.new(params[:date]).date
  end
end
