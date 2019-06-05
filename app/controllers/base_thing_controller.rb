# frozen_string_literal: true

class BaseThingController < BaseSubController
  before_action :set_thing

  private

  def set_thing
    @thing = @sub.things.find(params[:id])
  end

  def page_not_found
    if request.xhr?
      head :not_found
    else
      render "things/page_not_found", status: :not_found
    end
  end
end
