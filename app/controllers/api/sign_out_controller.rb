class Api::SignOutController < ApplicationController
  before_action -> { authorize(Api::SignOutPolicy) }

  def destroy
    request.env["warden"].logout

    head :no_content
  end
end
