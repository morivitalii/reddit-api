class PageNotFoundController < ApplicationController
  before_action -> { authorize(:page_not_found) }
  before_action :set_community
  decorates_assigned :community

  def show
    render status: :not_found
  end

  private

  def set_community
    @community = CommunitiesQuery.new.default.take!
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
