# frozen_string_literal: true

class HomeController < ApplicationController
  before_action -> { authorize(:home) }
  before_action :set_community
  decorates_assigned :community

  def index
    @records, @pagination = query.paginate(attributes: ["#{sorting}_score", :id], after: params[:after])
    @records = @records.map(&:decorate)
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

  helper_method :sorting
  def sorting
    sorting_options.include?(params[:sort]) ? params[:sort] : "hot"
  end

  helper_method :sorting_options
  def sorting_options
    %w(hot new top controversy)
  end

  helper_method :date
  def date
    date_options.include?(params[:date]) ? params[:date] : nil
  end

  helper_method :date_options
  def date_options
    %w(day week month)
  end

  def date_value
    # Time.now.advance does not accept string keys. wat?
    date.present? ? Time.now.advance("#{date}s".to_sym => -1) : nil
  end
end
