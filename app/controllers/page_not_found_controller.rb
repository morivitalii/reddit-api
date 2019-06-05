# frozen_string_literal: true

class PageNotFoundController < ApplicationController
  def show
    render "/page_not_found", status: :not_found
  end
end
