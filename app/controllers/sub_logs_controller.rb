# frozen_string_literal: true

class SubLogsController < BaseSubController
  before_action -> { authorize(@sub, policy_class: SubLogPolicy) }

  def index
    # N+1 db requests guaranteed, but who care if partials cached like forever anyway
    @records = Log.include(ReverseChronologicalOrder)
                   .where(sub: @sub)
                   .includes(:user, :loggable)
                   .sort_records_reverse_chronologically
                   .records_after(params[:after].present? ? @sub.logs.find_by_id(params[:after]) : nil)
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end
end
