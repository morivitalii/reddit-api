# frozen_string_literal: true

class SubModQueueController < BaseSubController
  layout "narrow"

  def index
    SubModQueuePolicy.authorize!(:index, @sub)

    @records = ModQueue.include(ReverseChronologicalOrder)
                   .where(sub: @sub)
                   .queue_type(helpers.mod_queue_filter(params[:mod_queue_type]))
                   .thing_type(helpers.thing_type_filter(params[:thing_type]))
                   .sort_records_reverse_chronologically
                   .records_after(params[:after].present? ? @sub.mod_queues.find_by_id(params[:after]) : nil)
                   .includes(thing: [:sub, :user, :post])
                   .limit(PaginationLimits.sub_mod_queue + 1)
                   .to_a

    if @records.size > PaginationLimits.sub_mod_queue
      @records.delete_at(-1)
      @after_record = @records.last
    end

    @records = @records.map(&:thing)
  end
end
