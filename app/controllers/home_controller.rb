# frozen_string_literal: true

class HomeController < ApplicationController
  layout "narrow"

  def index
    @records, @pagination_record = Thing.thing_type(:post)
                                       .not_deleted
                                       .in_date_range(date)
                                       .includes(:sub, :user)
                                       .paginate(attributes: ["#{sort}_score", :id], after: params[:after])
  end

  private

  def sort
    ThingsSorting.new(params[:sort]).key
  end

  def date
    ThingsDates.new(params[:date]).date
  end
end
