class Api::SignOutController < ApplicationController
  before_action -> { authorize(Api::SignOutPolicy) }

  def destroy
    request.env["warden"].logout

    head :no_content
  end

  private

  def pundit_user
    Context.new(current_user, nil)
  end
end
