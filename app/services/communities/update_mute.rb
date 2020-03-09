class Communities::UpdateMute
  include ActiveModel::Model

  attr_accessor :mute, :reason, :days, :permanent

  def call
    mute.update!(
      reason: reason,
      days: days,
      permanent: permanent
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end
end
