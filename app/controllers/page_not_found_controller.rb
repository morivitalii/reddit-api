# frozen_string_literal: true

class PageNotFoundController < ApplicationController
  skip_after_action :verify_authorized, only: [:show]

  def show
    render "show", status: :not_found
  end
end
