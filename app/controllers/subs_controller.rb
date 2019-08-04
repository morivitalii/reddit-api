# frozen_string_literal: true

class SubsController < ApplicationController
  before_action :set_sub
  before_action :set_facade
  before_action -> { authorize(@sub) }

  def show
    @records, @pagination = Post.not_removed
                                       .in_date_range(date)
                                       .where(sub: @sub)
                                       .includes(:sub, :user)
                                       .paginate(attributes: ["#{sort}_score", :id], after: params[:after])

    @records = @records.map(&:decorate)
  end

  def edit
    attributes = @sub.slice(:title, :description)

    @form = UpdateSub.new(attributes)
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

  def context
    Context.new(current_user, @sub)
  end

  def set_facade
    @facade = SubsFacade.new(context, @sub)
  end

  def set_sub
    @sub = SubsQuery.new.where_url(params[:id]).take!
  end

  def update_params
    attributes = policy(@sub).permitted_attributes_for_update

    params.require(:update_sub).permit(attributes).merge(sub: @sub, current_user: current_user)
  end

  def sort
    ThingsSorting.new(params[:sort]).key
  end

  def date
    ThingsDates.new(params[:date]).date
  end
end
