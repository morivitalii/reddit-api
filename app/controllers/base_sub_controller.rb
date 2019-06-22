# frozen_string_literal: true

class BaseSubController < ApplicationController
  before_action :set_sub
  before_action :set_navigation_title

  private

  def set_sub
    @sub = Sub.where("lower(url) = ?", params[:sub_id].downcase).take!
  end

  def set_navigation_title
    @navigation_title = @sub.title
  end
end
