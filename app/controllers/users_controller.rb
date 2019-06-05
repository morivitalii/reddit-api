# frozen_string_literal: true

class UsersController < BaseUserController
  layout "narrow"

  def show
    @records = Thing.thing_type(helpers.thing_type_filter(params[:thing_type]))
                   .not_deleted
                   .sort_records_by(helpers.thing_sort_filter(params[:thing_sort]))
                   .records_after(params[:after].present? ? @user.things.find_by_id(params[:after]) : nil, helpers.thing_sort_filter(params[:thing_sort]))
                   .records_after_date(helpers.thing_date_filter(params[:thing_date]))
                   .where(user: @user)
                   .includes(:sub, :user, :post)
                   .limit(PaginationLimits.user_things + 1)
                   .to_a

    if @records.size > PaginationLimits.user_things
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end
end
