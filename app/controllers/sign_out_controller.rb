# frozen_string_literal: true

class SignOutController < ApplicationController
  def destroy
    request.env["warden"].logout

    redirect_to root_path
  end
end
