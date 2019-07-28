# frozen_string_literal: true

class SubsController < ApplicationController
  layout "narrow", only: "show"
  before_action :set_sub
  before_action -> { authorize(@sub) }

  def show
    @records, @pagination_record = Thing.thing_type(:post)
                   .not_deleted
                   .in_date_range(date)
                   .where(sub: @sub)
                   .includes(:sub, :user)
                   .paginate(attributes: ["#{sort}_score", :id], after: params[:after])
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

  def pundit_user
    UserContext.new(current_user, @sub)
  end

  def set_sub
    @sub = Sub.where("lower(url) = ?", params[:id].downcase).take!
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
end
