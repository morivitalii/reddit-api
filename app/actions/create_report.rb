# frozen_string_literal: true

class CreateReport
  include ActiveModel::Model

  attr_accessor :thing, :current_user, :text

  def save
    return true if skip?

    report = @thing.reports.find_or_initialize_by(user: @current_user)
    report.text = @text

    report.save!
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end

  private

  def skip?
    @thing.ignore_reports?
  end
end
