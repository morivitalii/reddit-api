# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authorization
  include Pundit
  include PageNotFound

  before_action :set_default_facade
  after_action :verify_authorized

  private

  def context
    Context.new(current_user, SubsQuery.new.default.take!)
  end

  def set_default_facade
    @facade = ApplicationFacade.new(context)
  end
end
