# frozen_string_literal: true

class UpdateBanForm
  include ActiveModel::Model

  attr_accessor :ban, :reason, :days, :permanent

  def save
    ban.update!(
      reason: reason,
      days: days,
      permanent: permanent
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end

  def persisted?
    true
  end
end
