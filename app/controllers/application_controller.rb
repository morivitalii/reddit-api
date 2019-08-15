# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authorization
  include Pundit
  include PageNotFound

  after_action :verify_authorized
end
