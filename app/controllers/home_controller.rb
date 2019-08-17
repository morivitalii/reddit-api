# frozen_string_literal: true

class HomeController < ApplicationController
  before_action -> { authorize(:home) }
  before_action :set_community
  before_action :set_facade

  def index
    @records, @pagination = query.paginate(attributes: ["#{sorting}_score", :id], after: params[:after])
    @records = @records.map(&:decorate)
  end

  private

  def set_community
    @community = CommunitiesQuery.new.default.take!
  end

  def query
    query = PostsQuery.new.not_removed
    PostsQuery.new(query).search_created_after(date).includes(:community, :user)
  end

  helper_method :sorting
  def sorting
    sorting_options.include?(params[:sort]) ? params[:sort] : :hot
  end

  helper_method :sorting_options
  def sorting_options
    [:hot, :new, :top, :controversy]
  end

  def date
    ThingsDates.new(params[:date]).date
  end
end
