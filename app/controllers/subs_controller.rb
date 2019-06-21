# frozen_string_literal: true

class SubsController < BaseSubController
  layout "narrow", only: "show"
  skip_before_action :set_sub, only: [:index]
  skip_before_action :set_navigation_title, only: [:index]

  def index
    @records = Sub.include(ChronologicalOrder)
                   .sort_records_chronologically
                   .records_after(params[:after].present? ? Sub.find_by_id(params[:after]) : nil)
                   .limit(PaginationLimits.subs + 1)
                   .to_a

    if @records.size > PaginationLimits.subs
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
                   .limit(PaginationLimits.sub_things + 1)
                   .to_a

    if @records.size > PaginationLimits.sub_things
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

    @form = UpdateSub.new(update_params.merge(sub: @sub, current_user: Current.user))

    if @form.save
      head :no_content, location: sub_edit_path(@sub)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def update_params
    params.require(:update_sub).permit(:title, :description)
  end
end
