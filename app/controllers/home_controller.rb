# frozen_string_literal: true

class HomeController < ApplicationController
  before_action -> { authorize(:home) }
  before_action :set_community
  before_action :set_facade

  def index
    @records, @pagination = query.paginate(attributes: ["#{sort}_score", :id], after: params[:after])
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

  def sort
    ThingsSorting.new(params[:sort]).key
  end

  def date
    ThingsDates.new(params[:date]).date
  end
end
