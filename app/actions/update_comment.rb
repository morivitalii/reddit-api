# frozen_string_literal: true

class UpdateComment
  include ActiveModel::Model

  attr_accessor :comment, :current_user, :text, :ignore_reports

  def save
    attributes = {
      text: @text,
      ignore_reports: @ignore_reports
    }.compact

    if edited?
      @comment.edit(@current_user)
    end

    @comment.update!(attributes)
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end

  private

  def edited?
    @text.present? && @comment.text != @text
  end
end
