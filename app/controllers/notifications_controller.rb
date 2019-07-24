# frozen_string_literal: true

class NotificationsController < ApplicationController
  layout "narrow"

  before_action :set_user
  before_action :reset_counter
  before_action -> { authorize(Notification) }

  def index
    @records = Notification.where(user: @user)
                   .includes(notifiable: [:sub, :user, :post, :comment])
                   .reverse_chronologically(after)
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end

    @records = @records.map(&:notifiable)
  end

  private

  def set_user
    @user = current_user
  end

  def after
    params[:after].present? ? Notification.find_by_id(params[:after]) : nil
  end

  def reset_counter
    ResetNotificationsCounter.new(current_user: current_user).call
  end
end
