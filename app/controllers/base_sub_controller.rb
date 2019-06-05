# frozen_string_literal: true

class BaseSubController < ApplicationController
  before_action :set_sub
  before_action :set_navigation_title

  private

  def set_sub
    @sub = Sub.where("lower(url) = ?", params[:sub].downcase).take!
  end

  def set_navigation_title
    @navigation_title = @sub.title
  end

  def page_not_found
    if request.xhr?
      head :not_found
    else
      render "subs/page_not_found", status: :not_found
    end
  end
end
