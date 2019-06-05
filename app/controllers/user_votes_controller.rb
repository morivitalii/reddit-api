# frozen_string_literal: true

class UserVotesController < BaseUserController
  layout "narrow"

  def index
    UserVotesPolicy.authorize!(:index, @user)

    @records = Vote.include(ReverseChronologicalOrder)
                   .vote_type(helpers.vote_type_filter(params[:vote_type]))
                   .thing_type(helpers.thing_type_filter(params[:thing_type]))
                   .where(user: @user)
                   .includes(thing: [:sub, :user, :post])
                   .joins(:thing)
                   .merge(Thing.not_deleted)
                   .merge(Thing.where.not(user: @user))
                   .sort_records_reverse_chronologically
                   .records_after(params[:after].present? ? @user.votes.find_by_id(params[:after]) : nil)
                   .limit(PaginationLimits.user_votes + 1)
                   .to_a

    if @records.size > PaginationLimits.user_votes
      @records.delete_at(-1)
      @after_record = @records.last
    end

    @records = @records.map(&:thing)
  end
end
