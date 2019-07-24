# frozen_string_literal: true

class SubsController < ApplicationController
  layout "narrow", only: "show"
  before_action :set_sub
  before_action :set_navigation_title
  before_action -> { authorize(@sub) }

  def show
    @records = Thing.thing_type(:post)
                   .not_deleted
                   .chronologically(sort, after)
                   .in_date_range(date)
                   .where(sub: @sub)
                   .includes(:sub, :user)
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end

  def edit
    @form = UpdateSub.new(
      title: @sub.title,
      description: @sub.description
    )
  end

  def update
    @form = UpdateSub.new(update_params)

    if @form.save
      head :no_content, location: edit_sub_path(@sub)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def set_sub
    @sub = Sub.where("lower(url) = ?", params[:id].downcase).take!
  end

  def set_navigation_title
    @navigation_title = @sub.title
  end

  def update_params
    params.require(:update_sub).permit(:title, :description).merge(sub: @sub, current_user: current_user)
  end

  def sort
    ThingsSorting.new(params[:sort]).key
  end

  def date
    ThingsDates.new(params[:date]).date
  end

  def after
    params[:after].present? ? Thing.find_by_id(params[:after]) : nil
  end
end
