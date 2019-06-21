# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SetVariant
  include PageNotFound
  include Authorization
  include Navigation
end
