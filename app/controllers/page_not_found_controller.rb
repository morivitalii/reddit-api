# frozen_string_literal: true

class PageNotFoundController < ApplicationController
  before_action -> { authorize(:page_not_found) }

  def show
    render status: :not_found
  end

  private

  def pundit_user
    Context.new(current_user, CommunitiesQuery.new.default.take!)
  end
end
