# frozen_string_literal: true

class SubsController < ApplicationController
  layout "narrow", only: "show"
  before_action :set_sub, except: [:index]
  before_action :set_navigation_title, except: [:index]

  def index
    @records = Sub.include(ChronologicalOrder)
                   .sort_records_chronologically
                   .records_after(params[:after].present? ? Sub.find_by_id(params[:after]) : nil)
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end

    @navigation_title = t("subs")
  end

  def show
    @records = Thing.thing_type(:post)
                   .not_deleted
                   .sort_records_by(helpers.thing_sort_filter(params[:thing_sort]))
                   .records_after(params[:after].present? ? @sub.things.find_by_id(params[:after]) : nil, helpers.thing_sort_filter(params[:thing_sort]))
                   .records_after_date(helpers.thing_date_filter(params[:thing_date]))
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
    SubsPolicy.authorize!(:update, @sub)

    @form = UpdateSub.new(
        title: @sub.title,
        description: @sub.description
    )
  end

  def update
    SubsPolicy.authorize!(:update, @sub)

    @form = UpdateSub.new(update_params.merge(sub: @sub, current_user: current_user))

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
    params.require(:update_sub).permit(:title, :description)
  end
end
