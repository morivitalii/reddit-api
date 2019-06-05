# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SetVariant
  include Settings
  include PageNotFound
  include FormErrors
  include Authorization
  include Navigation
end
