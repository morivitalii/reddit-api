# frozen_string_literal: true

class PostController < ApplicationController
  before_action -> { authorize(Thing, policy_class: PostPolicy) }

  def new
    @records = Follow.include(Chronological)
                   .where(user: current_user)
                   .chronologically(params[:after].present? ? current_user.follows.find_by_id(params[:after]) : nil)
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
