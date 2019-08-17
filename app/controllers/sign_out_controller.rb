# frozen_string_literal: true

class SignOutController < ApplicationController
  before_action :set_facade
  before_action -> { authorize(:sign_out) }

  def destroy
    request.env["warden"].logout

    redirect_to root_path
  end
end
