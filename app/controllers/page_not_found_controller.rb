# frozen_string_literal: true

class PageNotFoundController < ApplicationController
  before_action -> { authorize(:page_not_found) }
  before_action :set_facade

  def show
    render status: :not_found
  end
end
