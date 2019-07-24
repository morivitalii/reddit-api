# frozen_string_literal: true

class HomeController < ApplicationController
  layout "narrow"

  before_action :set_navigation_title

  def index
    @records = Thing.thing_type(:post)
                   .not_deleted
                   .chronologically_by_score(sort, after)
                   .in_date_range(date)
                   .includes(:sub, :user)
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end

  private

  def sort
    ThingsSorting.new(params[:sort]).key
  end

  def after
    params[:after].present? ? Thing.find_by_id(params[:after]) : nil
  end

  def date
    ThingsDates.new(params[:date]).date
  end

  def set_navigation_title
    @navigation_title = t("home")
  end
end
