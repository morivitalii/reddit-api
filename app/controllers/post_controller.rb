# frozen_string_literal: true

class PostController < ApplicationController
  def new
    PostPolicy.authorize!(:new)
    @records = Follow.include(ChronologicalOrder)
                   .where(user: Current.user)
                   .sort_records_chronologically
                   .records_after(params[:after].present? ? Current.user.follows.find_by_id(params[:after]) : nil)
                   .includes(:sub)
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end

    @records = @records.map(&:sub)

    if @records.blank? && params[:after].blank?
      @records = Sub.order(follows_count: :desc).limit(50).all
    end
  end
end
