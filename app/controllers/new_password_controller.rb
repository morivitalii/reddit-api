# frozen_string_literal: true

class NewPasswordController < ApplicationController
  layout "blank"

  def new
    @form = NewPassword.new(link_params)
  end

  def create
    @form = NewPassword.new(create_params)
    @form.save!

    request.env["warden"].set_user(@form.user)

    head :no_content, location: root_path
  end

  private

  def link_params
    params.permit(:token)
  end

  def create_params
    params.require(:new_password).permit(:token, :password)
  end
end
