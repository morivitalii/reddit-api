# frozen_string_literal: true

class BaseThingController < ApplicationController
  before_action :set_thing

  private

  def set_thing
    @thing = Thing.find(params[:id])
  end
end
