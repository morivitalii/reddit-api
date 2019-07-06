# frozen_string_literal: true

class CreateThingReport
  include ActiveModel::Model

  attr_accessor :thing, :current_user, :text

  def save
    return false if @thing.reports_count >= 100
    return false if @thing.ignore_reports?

    report = @thing.reports.find_or_initialize_by(user: @current_user)
    report.assign_attributes(text: @text, created_at: Time.current)
    report.save!
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
