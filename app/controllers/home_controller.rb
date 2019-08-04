# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :set_facade
  before_action -> { authorize(:home) }

  def index
    @records, @pagination = Post.not_removed
                                       .in_date_range(date)
                                       .includes(:sub, :user)
                                       .paginate(attributes: ["#{sort}_score", :id], after: params[:after])

    @records = @records.map(&:decorate)
  end

  private

  def set_facade
    @facade = HomeFacade.new(context)
  end

  def sort
    ThingsSorting.new(params[:sort]).key
  end

  def date
    ThingsDates.new(params[:date]).date
  end
end
