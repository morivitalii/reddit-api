# frozen_string_literal: true

class CreateReportForm
  include ActiveModel::Model

  attr_accessor :reportable, :user, :text

  def save
    return true if reportable.ignore_reports?

    attributes = { community: reportable.community, text: text }

    Report.create_with(attributes).find_or_create_by!(reportable: reportable, user: user)
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end

  def persisted?
    false
  end
end
