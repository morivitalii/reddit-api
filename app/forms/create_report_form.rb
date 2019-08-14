# frozen_string_literal: true

class CreateReportForm
  include ActiveModel::Model

  attr_accessor :reportable, :user, :text

  def save
    return true if skip?

    Report.create_with(community: reportable.community, text: text).find_or_create_by!(reportable: reportable, user: user)
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end

  private

  def skip?
    reportable.ignore_reports?
  end
end
