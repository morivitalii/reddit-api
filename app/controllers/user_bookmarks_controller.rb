# frozen_string_literal: true

class UserBookmarksController < BaseUserController
  layout "narrow"

  def index
    UserBookmarksPolicy.authorize!(:index, @user)

    @records = Bookmark.include(ReverseChronologicalOrder)
                   .joins(:thing)
                   .merge(Thing.not_deleted)
                   .thing_type(helpers.thing_type_filter(params[:thing_type]))
                   .where(user: @user)
                   .sort_records_reverse_chronologically
                   .records_after(params[:after].present? ? @user.bookmarks.find_by_id(params[:after]) : nil)
                   .includes(thing: [:sub, :user, :post])
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end

    @records = @records.map(&:thing)
  end
end
