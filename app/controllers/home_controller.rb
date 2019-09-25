# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :set_community
  before_action -> { authorize(:home) }
  decorates_assigned :community, :posts

  def index
    @posts, @pagination = query.paginate(attributes: [sort_attribute, :id], after: params[:after])
  end

  private

  def pundit_user
    Context.new(current_user, @community)
  end

  def set_community
    @community = CommunitiesQuery.new.default.take!
  end

  def query
    query = PostsQuery.new.not_removed
    PostsQuery.new(query).search_created_after(date_value).includes(:community, :user)
  end

  helper_method :sorts
  def sorts
    %w(hot new top controversy)
  end

  helper_method :sort
  def sort
    sorts.include?(params[:sort]) ? params[:sort] : "hot"
  end

  def sort_attribute
    "#{sort}_score"
  end

  helper_method :dates
  def dates
    %w(day week month)
  end

  helper_method :date
  def date
    dates.include?(params[:date]) ? params[:date] : nil
  end

  def date_value
    # Time.now.advance does not accept string keys. wat?
    date.present? ? Time.now.advance("#{date}s".to_sym => -1) : nil
  end
end
