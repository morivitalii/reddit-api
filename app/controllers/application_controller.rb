# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authorization
  include Pundit
  include PageNotFound

  after_action :verify_authorized
  after_action :set_facade

  private

  def set_facade
    @facade = ApplicationFacade.new(context)
  end
end
