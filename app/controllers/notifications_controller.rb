# frozen_string_literal: true

class NotificationsController < ApplicationController
  layout "narrow"

  before_action :set_user
  before_action :reset_counter
  before_action :set_navigation_title
  before_action -> { authorize(Notification) }

  def index
    @records = Notification.include(ReverseChronologicalOrder)
                   .joins(:thing)
                   .merge(Thing.not_deleted)
                   .where(user: @user)
                   .includes(thing: [:sub, :user, :post, :comment])
                   .sort_records_reverse_chronologically
                   .records_after(params[:after].present? ? @user.notifications.find_by_id(params[:after]) : nil)
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end

    @records = @records.map(&:thing)
  end

  private

  def set_user
    @user = current_user
  end

  def reset_counter
    ResetNotificationsCounter.new(current_user: current_user).call
  end

  def set_navigation_title
    @navigation_title = t("notifications")
  end
end
