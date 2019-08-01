# frozen_string_literal: true

class PasswordController < ApplicationController
  layout "blank"

  before_action -> { authorize(:password) }

  def edit
    @form = ChangePassword.new(link_params)
  end

  def update
    @form = ChangePassword.new(create_params)

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

    params.require(:change_password).permit(attributes)
  end
end
