# frozen_string_literal: true

class NotificationsController < ApplicationController
  layout "narrow"

  before_action :set_user
  before_action :reset_counter
  before_action -> { authorize(Notification) }

  def index
    @records, @pagination_record = Notification.where(user: @user)
                                       .includes(notifiable: [:sub, :user, :post, :comment])
                                       .paginate(after: params[:after])

    @records = @records.map(&:notifiable)
  end

  private

  def set_user
    @user = current_user
  end

  def reset_counter
    ResetNotificationsCounter.new(current_user: current_user).call
  end
end
