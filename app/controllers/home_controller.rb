# frozen_string_literal: true

class HomeController < ApplicationController
  layout "narrow"

  before_action :set_navigation_title

  def index
    @records = Thing.thing_type(:post)
                   .not_deleted
                   .sort_records_by(helpers.thing_sort_filter(params[:thing_sort]))
                   .records_after(params[:after].present? ? Thing.find_by_id(params[:after]) : nil, helpers.thing_date_filter(params[:thing_date]))
                   .records_after_date(@date)
                   .includes(:sub, :user)
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end

  private

  def set_navigation_title
    @navigation_title = t("home")
  end
end
