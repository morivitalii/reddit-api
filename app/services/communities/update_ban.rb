class Communities::UpdateBan
  include ActiveModel::Model

  attr_accessor :ban, :reason, :days, :permanent

  def call
    ban.update!(
      reason: reason,
      days: days,
      permanent: permanent
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end
end
