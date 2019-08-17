# frozen_string_literal: true

class PasswordController < ApplicationController
  before_action -> { authorize(:password) }
  before_action :set_facade

  def edit
    @form = ChangePasswordForm.new(link_params)
  end

  def update
    @form = ChangePasswordForm.new(create_params)

    if @form.save
      request.env["warden"].set_user(@form.user)

      head :no_content, location: root_path
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def link_params
    params.permit(:token)
  end

  def create_params
    attributes = policy(:password).permitted_attributes_for_update

    params.require(:change_password_form).permit(attributes)
  end
end
