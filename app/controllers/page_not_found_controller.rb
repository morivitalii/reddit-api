# frozen_string_literal: true

class PageNotFoundController < ApplicationController
  skip_after_action :verify_authorized, only: [:show]

  def show
    render "/page_not_found", status: :not_found
  end
end
