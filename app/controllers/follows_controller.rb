# frozen_string_literal: true

class FollowsController < ApplicationController
  before_action -> { authorize(Follow) }
  before_action :set_sub

  def create
    CreateFollow.new(sub: @sub, current_user: current_user).call

    head :no_content
  end

  def destroy
    DeleteFollow.new(sub: @sub, current_user: current_user).call

    head :no_content
  end

  private

  def set_sub
    @sub = Sub.where("lower(url) = ?", params[:sub_id].downcase).take!
  end
end
