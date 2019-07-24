# frozen_string_literal: true

class CreateReport
  include ActiveModel::Model

  attr_accessor :model, :current_user, :text

  def save
    return true if skip?

    report = @model.reports.find_or_initialize_by(user: @current_user)
    report.assign_attributes(sub: @model.sub, text: @text)

    report.save!
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end

  private

  def skip?
    @model.ignore_reports?
  end
end
