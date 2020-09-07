class Communities::UpdateMute
  include ActiveModel::Model

  attr_accessor :mute, :updated_by, :end_at

  def call
    mute.update!(
      updated_by: updated_by,
      end_at: end_at
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end
end
