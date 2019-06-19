# frozen_string_literal: true

class BaseThingController < BaseSubController
  before_action :set_thing

  private

  def set_thing
    @thing = @sub.things.find(params[:id])
  end
end
