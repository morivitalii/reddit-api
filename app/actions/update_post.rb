# frozen_string_literal: true

class UpdatePost
  include ActiveModel::Model

  attr_accessor :post, :current_user, :text, :tag, :explicit, :spoiler, :ignore_reports, :receive_notifications

  def save
    attributes = {
      text: @text,
      tag: @tag,
      explicit: @explicit,
      spoiler: @spoiler,
      ignore_reports: @ignore_reports,
      receive_notifications: @receive_notifications,
    }.compact

    if edited?
      attributes[:edited_by] = @current_user
      attributes[:edited_at] = Time.current
    end

    @post.update!(attributes)
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
    end

  private

  def edited?
    @post.text != @text
  end
end
