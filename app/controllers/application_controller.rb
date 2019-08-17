# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authorization
  include Pundit
  include PageNotFound

  after_action :verify_authorized
  after_action :set_facade

  private

  def context
    default_community = CommunitiesQuery.new.default.take!

    Context.new(current_user, default_community)
  end

  def set_facade
    @facade = ApplicationFacade.new(context)
  end
end
