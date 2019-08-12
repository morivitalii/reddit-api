# frozen_string_literal: true

class FollowsController < ApplicationController
  before_action :set_sub
  before_action -> { authorize(Follow) }

  def create
    CreateFollowService.new(@sub, current_user).call

    head :no_content
  end

  def destroy
    DeleteFollowService.new(@sub, current_user).call

    head :no_content
  end

  private

  def pundit_user
    Context.new(current_user, @sub)
  end

  def set_sub
    @sub = SubsQuery.new.with_url(params[:sub_id]).take!
  end
end
