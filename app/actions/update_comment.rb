# frozen_string_literal: true

class UpdateComment
  include ActiveModel::Model

  attr_accessor :comment, :current_user, :text, :ignore_reports, :receive_notifications

  def save
    attributes = {
      text: @text,
      ignore_reports: @ignore_reports,
      receive_notifications: @receive_notifications,
    }.compact

    if edited?
      attributes[:edited_by] = @current_user
      attributes[:edited_at] = Time.current
    end

    @comment.update!(attributes)
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
