# frozen_string_literal: true

class UserSettingsController < ApplicationController
  before_action :set_user
  before_action :set_navigation_title

  def edit
    UserSettingsPolicy.authorize!(:update)

    @form = UpdateUserSettings.new(email: @user.email)
  end

  def update
    UserSettingsPolicy.authorize!(:update)

    @form = UpdateUserSettings.new(update_params.merge(user: @user))

    if @form.save
      head :no_content, location: user_settings_edit_path
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = Current.user
  end

  def set_navigation_title
    @navigation_title = t("settings")
  end

  def update_params
    params.require(:update_user_settings).permit(:email, :password, :password_current)
  end
end
