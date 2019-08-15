# frozen_string_literal: true

class SignOutController < ApplicationController
  before_action -> { authorize(:sign_out) }

  def destroy
    request.env["warden"].logout

    redirect_to root_path
  end

  private

  def context
    Context.new(current_user)
  end
end
