# frozen_string_literal: true

class FollowsController < ApplicationController
  before_action :set_community
  before_action :set_facade
  before_action -> { authorize(Follow) }

  def create
    CreateFollowService.new(@community, current_user).call

    head :no_content
  end

  def destroy
    DeleteFollowService.new(@community, current_user).call

    head :no_content
  end

  private

  def context
    Context.new(current_user, @community)
  end

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end
end
