# frozen_string_literal: true

class BaseUserController < ApplicationController
  before_action :set_user
  before_action :set_navigation_title

  private

  def set_user
    @user = User.where("lower(username) = ?", params[:username].downcase).take!
  end

  def set_navigation_title
    @navigation_title = @user.username
  end
end
