# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user
  before_action -> { authorize(@user) }
  decorates_assigned :user

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
    @user = current_user
  end

  def update_params
    attributes = policy(@user).permitted_attributes_for_update
    params.require(:update_user_form).permit(attributes).merge(user: @user)
  end
end
