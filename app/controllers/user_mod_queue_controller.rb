# frozen_string_literal: true

class UserModQueueController < BaseUserController
  layout "narrow"

  before_action :set_navigation_title

  def index
    UserModQueuePolicy.authorize!(:index, @user)

    @records = ModQueue.include(ReverseChronologicalOrder)
                   .queue_type(helpers.mod_queue_filter(params[:mod_queue_type]))
                   .thing_type(helpers.thing_type_filter(params[:thing_type]))
                   .joins(sub: :moderators)
                   .where(subs: { moderators: { user: @user } })
                   .includes(thing: [:sub, :user, :post])
                   .sort_records_reverse_chronologically
                   .records_after(params[:after].present? ? ModQueue.find_by_id(params[:after]) : nil)
                   .limit(PaginationLimits.user_mod_queue + 1)
                   .to_a

    if @records.size > PaginationLimits.user_mod_queue
      @records.delete_at(-1)
      @after_record = @records.last
    end

    @records = @records.map(&:thing)
  end

  private

  def set_navigation_title
    @navigation_title = t("mod_queue")
  end
end
