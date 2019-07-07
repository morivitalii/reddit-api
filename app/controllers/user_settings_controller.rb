# frozen_string_literal: true

class UserSettingsController < ApplicationController
  before_action :set_user
  before_action :set_navigation_title
  before_action -> { authorize(User, policy_class: UserSettingsPolicy) }

  def edit
    @form = UpdateUserSettings.new(email: @user.email)
  end

  def update
    @form = UpdateUserSettings.new(update_params)

    if @form.save
      head :no_content, location: edit_user_settings_path
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def set_navigation_title
    @navigation_title = t("settings")
  end

  def update_params
    params.require(:update_user_settings).permit(:email, :password, :password_current).merge(user: @user)
  end
end
