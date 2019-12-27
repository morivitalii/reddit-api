class Api::SignOutController < ApplicationController
  before_action -> { authorize(nil, policy_class: Api::SignOutPolicy) }

  def destroy
    request.env["warden"].logout

    redirect_to root_path
  end
end
