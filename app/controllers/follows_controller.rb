# frozen_string_literal: true

class FollowsController < ApplicationController
  before_action -> { authorize(Follow) }
  before_action :set_sub

  def create
    CreateFollowService.new(@sub, current_user).call

    head :no_content
  end

  def destroy
    DeleteFollow.new(sub: @sub, current_user: current_user).call

    head :no_content
  end

  private

  def pundit_user
    Context.new(current_user, @sub)
  end

  def set_sub
    @sub = SubsQuery.new.where_url(params[:sub_id]).take!
  end
end
